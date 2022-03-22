CREATE TABLE Caregivers (
    Username varchar(255),
    Salt BINARY(16),
    Hash BINARY(16),
    PRIMARY KEY (Username)
);

CREATE TABLE Patients (
    Username varchar(255),
    Salt BINARY(16),
    Hash BINARY(16),
    PRIMARY KEY (Username)
);

CREATE TABLE Vaccines (
    Name varchar(255),
    Doses int,
    PRIMARY KEY (Name)
);

CREATE TABLE Availabilities (
    Time date,
    Username varchar(255) REFERENCES Caregivers,
    PRIMARY KEY (Time, Username)
);

CREATE TABLE Appointments (
    aID INT IDENTITY (1, 1) UNIQUE,
    Vaccine_name VARCHAR(255) REFERENCES Vaccines(Name),
    Time date,
    Caregiver_name VARCHAR(255) REFERENCES Caregivers(Username),
    Patient_name VARCHAR(255) REFERENCES Patients(Username),
    PRIMARY KEY (Time, Patient_name)
);

