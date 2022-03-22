package scheduler;

import scheduler.db.ConnectionManager;
import scheduler.model.Caregiver;
import scheduler.model.Patient;
import scheduler.model.Vaccine;
import scheduler.util.Util;

import javax.xml.transform.Result;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Date;


public class Scheduler {

    // objects to keep track of the currently logged-in user
    // Note: it is always true that at most one of currentCaregiver and currentPatient is not null
    //       since only one user can be logged-in at a time
    private static Caregiver currentCaregiver = null;
    private static Patient currentPatient = null;

    public static void main(String[] args) {
//        printing greetings text
//        System.out.println();
//        System.out.println("Welcome to the COVID-19 Vaccine Reservation Scheduling Application!");
//        System.out.println("*** Please enter one of the following commands ***");
//        System.out.println("> create_patient <username> <password>");  //TODO: implement create_patient (Part 1) ✅
//        System.out.println("> create_caregiver <username> <password>"); // ✅
//        System.out.println("> login_patient <username> <password>");  // TODO: implement login_patient (Part 1) ✅
//        System.out.println("> login_caregiver <username> <password>"); // ✅
//        System.out.println("> search_caregiver_schedule <date>");  // TODO: implement search_caregiver_schedule (Part 2) ✅
//        System.out.println("> reserve <date> <vaccine>");  // TODO: implement reserve (Part 2) ✅
//        System.out.println("> upload_availability <date>"); // ✅
//        System.out.println("> cancel <appointment_id>");  // TODO: implement cancel (extra credit) ✅
//        System.out.println("> add_doses <vaccine> <number>"); // ✅
//        System.out.println("> show_appointments");  // TODO: implement show_appointments (Part 2) ✅
//        System.out.println("> logout");  // TODO: implement logout (Part 2) ✅
//        System.out.println("> quit");
//        System.out.println();

        // read input from user
        BufferedReader r = new BufferedReader(new InputStreamReader(System.in));
        while (true) {
            System.out.println();
            System.out.println("Welcome to the COVID-19 Vaccine Reservation Scheduling Application!");
            System.out.println("*** Please enter one of the following commands ***");
            System.out.println("> create_patient <username> <password>");  //TODO: implement create_patient (Part 1)
            System.out.println("> create_caregiver <username> <password>");
            System.out.println("> login_patient <username> <password>");  // TODO: implement login_patient (Part 1)
            System.out.println("> login_caregiver <username> <password>");
            System.out.println("> search_caregiver_schedule <date>");  // TODO: implement search_caregiver_schedule (Part 2)
            System.out.println("> reserve <date> <vaccine>");  // TODO: implement reserve (Part 2)
            System.out.println("> upload_availability <date>");
            System.out.println("> cancel <appointment_id>");  // TODO: implement cancel (extra credit)
            System.out.println("> add_doses <vaccine> <number>");
            System.out.println("> show_appointments");  // TODO: implement show_appointments (Part 2)
            System.out.println("> logout");  // TODO: implement logout (Part 2)
            System.out.println("> quit");
            System.out.println();
            System.out.print("> ");
            String response = "";
            try {
                response = r.readLine();
            } catch (IOException e) {
                System.out.println("Please try again!");
            }
            // split the user input by spaces
            String[] tokens = response.split(" ");
            // check if input exists
            if (tokens.length == 0) {
                System.out.println("Please try again!");
                continue;
            }
            // determine which operation to perform
            String operation = tokens[0];
            if (operation.equals("create_patient")) {
                createPatient(tokens);
            } else if (operation.equals("create_caregiver")) {
                createCaregiver(tokens);
            } else if (operation.equals("login_patient")) {
                loginPatient(tokens);
            } else if (operation.equals("login_caregiver")) {
                loginCaregiver(tokens);
            } else if (operation.equals("search_caregiver_schedule")) {
                searchCaregiverSchedule(tokens);
            } else if (operation.equals("reserve")) {
                reserve(tokens);
            } else if (operation.equals("upload_availability")) {
                uploadAvailability(tokens);
            } else if (operation.equals("cancel")) {
                cancel(tokens);
            } else if (operation.equals("add_doses")) {
                addDoses(tokens);
            } else if (operation.equals("show_appointments")) {
                showAppointments(tokens);
            } else if (operation.equals("logout")) {
                logout(tokens);
            } else if (operation.equals("quit")) {
                System.out.println("Bye!");
                return;
            } else {
                System.out.println("Invalid operation name!");
            }
        }
    }

    private static void createPatient(String[] tokens) {
        // TODO: Part 1 ✅
        // create_patient <username> <password>
        // check 1: the length for tokens need to be exactly 3 to include all information (with the operation name)
        if (tokens.length != 3) {
            System.out.println("Please try again!");
            return;
        }

        // the first field should be the input username and
        // the second field should be the input password
        String username = tokens[1];
        String password = tokens[2];

        // check 2: check if the username has been taken already
        if (usernameExistsPatient(username)) {
            System.out.println("Username taken, try again!");
            return;
        }

        byte[] salt = Util.generateSalt();
        byte[] hash = Util.generateHash(password, salt);
        // create the patient
        try {
            currentPatient = new Patient.PatientBuilder(username, salt, hash).build();
            //
            currentPatient.saveToDB();
            System.out.println(" *** Account created successfully *** ");
        } catch (SQLException e) {
            System.out.println("Create Failed");
            e.printStackTrace();
        }
    }

    private static void createCaregiver(String[] tokens) {
        // create_caregiver <username> <password>
        // check 1: the length for tokens need to be exactly 3 to include all information (with the operation name)
        if (tokens.length != 3) {
            System.out.println("Please try again!");
            return;
        }

        // The first field should be the input username and
        // The second field should be the input password
        String username = tokens[1];
        String password = tokens[2];

        // check 2: check if the username has been taken already
        if (usernameExistsCaregiver(username)) {
            System.out.println("Username taken, try again!");
            return;
        }
        byte[] salt = Util.generateSalt();
        byte[] hash = Util.generateHash(password, salt);
        // create the caregiver
        try {
            currentCaregiver = new Caregiver.CaregiverBuilder(username, salt, hash).build();
            // save to caregiver information to our database
            currentCaregiver.saveToDB();
            System.out.println(" *** Account created successfully *** ");
        } catch (SQLException e) {
            System.out.println("Create failed");
            e.printStackTrace();
        }
    }

    private static boolean usernameExistsCaregiver(String username) {
        ConnectionManager cm = new ConnectionManager();
        Connection con = cm.createConnection();

        String selectUsername = "SELECT * FROM Caregivers WHERE Username = ?";
        try {
            PreparedStatement statement = con.prepareStatement(selectUsername);
            statement.setString(1, username);
            ResultSet resultSet = statement.executeQuery();
            // returns false if the cursor is not before the first record or if there are no rows in the ResultSet.
            return resultSet.isBeforeFirst();
        } catch (SQLException e) {
            System.out.println("Error occurred when checking username");
            e.printStackTrace();
        } finally {
            cm.closeConnection();
        }
        return true;
    }


    //
    private static boolean usernameExistsPatient(String username) {
        ConnectionManager cm = new ConnectionManager();
        Connection con = cm.createConnection();

        String selectUsername = "SELECT * FROM Patients WHERE Username = ?";
        try {
            PreparedStatement statement = con.prepareStatement(selectUsername);
            statement.setString(1, username);
            ResultSet resultSet = statement.executeQuery();
            return resultSet.isBeforeFirst();
        } catch (SQLException e) {
            System.out.println("Error occurred when checking username");
            e.printStackTrace();
        } finally {
            cm.closeConnection();
        }
        return true;
    }


    private static void loginPatient(String[] tokens) {
        // TODO: Part 1 ✅
        if (currentCaregiver != null || currentPatient != null) {
            System.out.println("Already logged-in!");
            return;
        }
        if (tokens.length != 3) {
            System.out.println("Try again");
            return;
        }
        String username = tokens[1];
        String password = tokens[2];

        Patient patient = null;
        try {
            patient = new Patient.PatientGetter(username, password).get();
        } catch (SQLException e) {
            System.out.println("Error occurred when logging in");
            e.printStackTrace();
        }

        if (patient == null) {
            System.out.println("Please try again!");
        } else {
            System.out.println("Patient logged in as: " + username);
            currentPatient = patient;
        }
    }

    private static void loginCaregiver(String[] tokens) {
        // login_caregiver <username> <password>
        // check 1: if someone's already logged-in, they need to log out first
        if (currentCaregiver != null || currentPatient != null) {
            System.out.println("Already logged-in!");
            return;
        }
        // check 2: the length for tokens need to be exactly 3 to include all information (with the operation name)
        if (tokens.length != 3) {
            System.out.println("Please try again!");
            return;
        }
        String username = tokens[1];
        String password = tokens[2];

        Caregiver caregiver = null;
        try {
            caregiver = new Caregiver.CaregiverGetter(username, password).get();
        } catch (SQLException e) {
            System.out.println("Error occurred when logging in");
            e.printStackTrace();
        }
        // check if the login was successful
        if (caregiver == null) {
            System.out.println("Please try again!");
        } else {
            System.out.println("Caregiver logged in as: " + username);
            currentCaregiver = caregiver;
        }
    }

    private static void searchCaregiverSchedule(String[] tokens) {
        // TODO: Part 2 ✅
        // check 1: check if the current logged-in user is a caregiver or a patient
        if (currentCaregiver == null && currentPatient == null) {
            System.out.println("Please login first!");
            return;
        }

        // check 2: the length of the tokens need to be exactly 2 to include all information (with the operation name)
        if (tokens.length != 2) {
            System.out.println("Please try again!");
            return;
        }

        ConnectionManager cm = new ConnectionManager();
        Connection con = cm.createConnection();

        // Search the caregiver schedule and the number of available doses left for each vaccine
        String date = tokens[1];
        String searchSchedule = "SELECT DISTINCT Username FROM Availabilities WHERE Time = ?";
        String searchVaccineDoses = "SELECT Name, Doses FROM Vaccines";
        try {
            Date d = Date.valueOf(date);
            PreparedStatement statementS = con.prepareStatement(searchSchedule);
            PreparedStatement statementV = con.prepareStatement(searchVaccineDoses);
            statementS.setDate(1, d);
            ResultSet rsS = statementS.executeQuery();
            ResultSet rsV = statementV.executeQuery();
            int count = 0;
            while (rsS.next()) {
                System.out.println("Caregiver's name: " + rsS.getString(1));
                count++;
            }
            if (count == 0) {
                System.out.println("the date is not available");
                return;
            }
            while (rsV.next()) {
                System.out.println("Vaccine's name: " + rsV.getString(1) + ", available_doses: " +
                        rsV.getInt(2));
            }
            System.out.println("Here are the available dates for vaccination");
        } catch (IllegalArgumentException e) {
            System.out.println("Please enter a valid date!");
        } catch (SQLException e) {
            System.out.println("Error occurred when searching caregivers' schedules");
            e.printStackTrace();
        } finally {
            cm.closeConnection();
        }
    }

    private static void reserve(String[] tokens) {
        // TODO: Part 2
        // check 1: check if the current logged-in user is a patient
        if (currentPatient == null) {
            System.out.println("Please login as a patient first!");
            return;
        }

        // check 2: the length for tokens need to be exactly 3 to include all information
        if (tokens.length != 3) {
            System.out.println("Please try again!");
            return;
        }

        String date = tokens[1];
        String inputVaccine = tokens[2];
        Date d = Date.valueOf(date);
        String vaccineName = null;

        Vaccine vaccine = null;

        ConnectionManager cm = new ConnectionManager();
        Connection con = cm.createConnection();

        String caregiverName = null;

        // check 3: One patient could only make one appointment a day
        try {
            String checkApp = "SELECT * FROM Appointments WHERE Time = ? AND Patient_name = ?";
            PreparedStatement checkStatement = con.prepareStatement(checkApp);
            checkStatement.setDate(1, d);
            checkStatement.setString(2, currentPatient.getUsername());
            ResultSet rs = checkStatement.executeQuery();
            if (rs.next()) {
                System.out.println("You have reserved an appointment on this day and you can only make one " +
                        "appointment on a single day.");
                return;
            }
        } catch (SQLException e) {
            System.out.println("Error occurred when checking the reserved appointments");
            e.printStackTrace();
        }

        // check 4: check whether the date is available and randomly assigned a caregiver on that date.
        try {

            String checkDates = "SELECT TOP 1 Username FROM Availabilities WHERE Time = ? ORDER BY NEWID()";
            PreparedStatement statementCheck = con.prepareStatement(checkDates);
            statementCheck.setString(1, date);
            ResultSet rs = statementCheck.executeQuery();
            if (!rs.next()) {
                System.out.println("The date is not available");
                return;
            }
            caregiverName = rs.getString(1);
        } catch (SQLException e){
            System.out.println("Error occurred when assigning a caregiver");
            e.printStackTrace();
        } catch (IllegalArgumentException e) {
            System.out.println("Please enter an valid date");
            return;
        }

        // check 5: check whether the vaccine has enough available doses is available
        try {
            vaccine = new Vaccine.VaccineGetter(inputVaccine).get();
            if (vaccine == null) {
                System.out.println("The vaccine does not exist");
                System.out.println("Please try again");
                return;
            }
            vaccineName = vaccine.getVaccineName();
            vaccine.decreaseAvailableDoses(1);
            System.out.println("The number of doses of " + vaccine.getVaccineName() + " decreases by 1");
        } catch (IllegalArgumentException e) {
            System.out.println("Not enough available doses");
            return;
        } catch (SQLException e) {
            System.out.println("Error occurred when decreasing the available doses");
            e.printStackTrace();
        } finally {
            cm.closeConnection();
        }

        // Reserve an appointment
        try {
            // Delete the availability in table Availability
            currentPatient.reserve(d, vaccineName, caregiverName);
            System.out.println("You make an appointment successfully!");
        } catch (SQLException e) {
            System.out.println("Error occurred when reserving an appointment");
            e.printStackTrace();
        }
    }

    private static void uploadAvailability(String[] tokens) {
        // upload_availability <date>
        // check 1: check if the current logged-in user is a caregiver
        if (currentCaregiver == null) {
            System.out.println("Please login as a caregiver first!");
            return;
        }
        // check 2: the length for tokens need to be exactly 2 to include all information (with the operation name)
        if (tokens.length != 2) {
            System.out.println("Please try again!");
            return;
        }

        String date = tokens[1];
        try {
            Date d = Date.valueOf(date);
            currentCaregiver.uploadAvailability(d);
            System.out.println("Availability uploaded!");
        } catch (IllegalArgumentException e) {
            System.out.println("Please enter a valid date!");
        } catch (SQLException e) {
            System.out.println("Error occurred when uploading availability");
            e.printStackTrace();
        }
    }

    private static void cancel(String[] tokens) {
        // TODO: Extra credit

        // check 1: check whether user has logged in
        if (currentCaregiver == null && currentPatient == null) {
            System.out.println("Please login first");
            return;
        }

        // check 2: check whether the length of tokens is 2
        if (tokens.length != 2) {
            System.out.println("Please try again!");
            return;
        }

        int aid = Integer.parseInt(tokens[1]);

        ConnectionManager cm = new ConnectionManager();
        Connection con = cm.createConnection();

        String vaccineName = null;
        Date d = null;
        String caregiverName = null;

        // check 3: check whether the appointment id is valid
        try {
            String checkID = "SELECT Vaccine_name, Time, Caregiver_name, Patient_name FROM Appointments WHERE aID = ?";
            PreparedStatement checkIDStatement = con.prepareStatement(checkID);
            checkIDStatement.setInt(1, aid);
            ResultSet rs = checkIDStatement.executeQuery();
            // check whether the appointment id is valid
            if (!rs.next()) {
                System.out.println("This appointment does not exist");
                return;
            }
            vaccineName = rs.getString(1);
            d = rs.getDate(2);
            caregiverName = rs.getString(3);

        } catch (SQLException e) {
            System.out.println("Error occurred when checking appointment id");
        }

        // delete the row in Appointment and add a row in availability, increase number of doses of the vaccine
        try {
            // delete the row in Appointment
            String deleteStr = "DELETE FROM Appointments WHERE aID = ?";
            PreparedStatement deleteStatement = con.prepareStatement(deleteStr);
            deleteStatement.setInt(1, aid);
            deleteStatement.execute();

            // add a row in availability
            String addStr = "INSERT INTO Availabilities VALUES (?, ?)";
            PreparedStatement addStatement = con.prepareStatement(addStr);
            addStatement.setDate(1, d);
            addStatement.setString(2, caregiverName);
            addStatement.execute();

            // increase number of doses of the vaccine
            Vaccine vaccine = new Vaccine.VaccineGetter(vaccineName).get();
            vaccine.increaseAvailableDoses(1);
            System.out.println("Appointment cancelled successfully!");
        } catch (SQLException e) {
            System.out.println("Error occurred when canceling appointment");
            e.printStackTrace();
        } finally {
            cm.closeConnection();
        }




    }

    private static void addDoses(String[] tokens) {
        // add_doses <vaccine> <number>
        // check 1: check if the current logged-in user is a caregiver
        if (currentCaregiver == null) {
            System.out.println("Please login as a caregiver first!");
            return;
        }
        // check 2: the length for tokens need to be exactly 3 to include all information (with the operation name)
        if (tokens.length != 3) {
            System.out.println("Please try again!");
            return;
        }
        String vaccineName = tokens[1];
        int doses = Integer.parseInt(tokens[2]);
        Vaccine vaccine = null;
        try {
            vaccine = new Vaccine.VaccineGetter(vaccineName).get();
        } catch (SQLException e) {
            System.out.println("Error occurred when adding doses");
            e.printStackTrace();
        }
        // check 3: if getter returns null, it means that we need to create the vaccine and insert it into the Vaccines
        //          table
        if (vaccine == null) {
            try {
                vaccine = new Vaccine.VaccineBuilder(vaccineName, doses).build();
                vaccine.saveToDB();
            } catch (SQLException e) {
                System.out.println("Error occurred when adding doses");
                e.printStackTrace();
            }
        } else {
            // if the vaccine is not null, meaning that the vaccine already exists in our table
            try {
                vaccine.increaseAvailableDoses(doses);
            } catch (SQLException e) {
                System.out.println("Error occurred when adding doses");
                e.printStackTrace();
            }
        }
        System.out.println("Doses updated!");
    }

    private static void showAppointments(String[] tokens) {
        // TODO: Part 2
        // check 1: check the logged-in user
        if (currentCaregiver == null && currentPatient == null) {
            System.out.println("Please log in first");
            return;
        }

        // check 2: check the length of the user input
        if (tokens.length != 1) {
            System.out.println("please try again!");
            return;
        }

        ConnectionManager cm = new ConnectionManager();
        Connection con = cm.createConnection();

        String printAppointments = "SELECT * FROM Appointments";


        try {
            int printN = 0;
            String printUser = "";
            PreparedStatement getResult = null;

            if (currentPatient != null) {
                // logged-in user is a patient
                getResult = con.prepareStatement(printAppointments + " WHERE Patient_name = ?");
                getResult.setString(1, currentPatient.getUsername());
                printUser = "Caregiver_name";
                printN = 4;
            } else {
                // logged-in user is a caregiver
                getResult = con.prepareStatement(printAppointments + " WHERE Caregiver_name = ?");
                getResult.setString(1, currentCaregiver.getUsername());
                printUser = "Patient_name";
                printN = 5;
            }

            ResultSet rs = getResult.executeQuery();

            while (rs.next()) {
                System.out.println("Appointment ID: " + rs.getInt(1) + ", vaccine name: " +
                        rs.getString(2) + ", date: " + rs.getDate(3) + ", " +
                        printUser + ": " + rs.getString(printN));
            }
            System.out.println("Show appointments successfully!");
        } catch (SQLException e) {
            System.out.println("Error occurred when showing appointments");
            e.printStackTrace();
        } finally {
            cm.closeConnection();
        }
    }

    private static void logout(String[] tokens) {
        // TODO: Part 2
        if (currentCaregiver == null && currentPatient == null) {
            System.out.println("You have been logged out");
        } else if (currentPatient != null) {
            currentPatient = null;
            System.out.println("Logout successfully");
        } else {
            currentCaregiver = null;
            System.out.println("Logout successfully");
        }
    }
}
