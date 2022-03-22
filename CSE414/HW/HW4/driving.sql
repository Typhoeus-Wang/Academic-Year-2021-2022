CREATE TABLE InsuranceCo (
    name VARCHAR(255) PRIMARY KEY,
    phone INT
)

CREATE TABLE Vehicle (
    licensePlate VARCHAR(255) PRIMARY KEY,
    year INT,
    insuranceName VARCHAR(255) REFERENCES InsuranceCo(name),
    ownedBy VARCHAR(255) REFERENCES Person(ssn),
    maxLiability REAL
)

CREATE TABLE Car (
    licensePlate VARCHAR(255) PRIMARY KEY REFERENCES Vehicle(licensePlate),
    make VARCHAR(255)
)

CREATE TABLE Truck (
    licensePlate VARCHAR(255) PRIMARY KEY REFERENCES Vehicle(licensePlate),
    capacity INT,
    operatedBy VARCHAR(255) REFERENCES ProfessionalDriver(driverID)
)

CREATE TABLE Person (
    ssn INT PRIMARY KEY,
    name VARCHAR(255)
)

CREATE TABLE Driver (
    name VARCHAR(255) PRIMARY KEY REFERENCES Person(ssn),
    driverID INT UNIQUE
)

CREATE TABLE NonProfessionalDriver (
    driverID VARCHAR(255) PRIMARY KEY REFERENCES Driver(driverID)
)

CREATE TABLE ProfessionalDriver (
    driverID VARCHAR(255) PRIMARY KEY REFERENCES Driver(driverID),
    medicalHistory VARCHAR(255)
)

CREATE TABLE Drives (
    carName VARCHAR(255) REFERENCES Car(licensePlate),
    driverName VARCHAR(255) REFERENCES NonProfessionalDriver(driverID),
    PRIMARY KEY(carName, driverName)
)


/* (b) 
I use an attribute insuranceName references InsuranceCo to represent the relationship "insures"
Because this is a one-to-many relationship which means every vehicle could only insured by one 
insurance company, I use a foreign key of vehicle to refer to the insufance company.AS
*/


/* (c)
The representation of "drives" is a table while the representation of "operates" is an attribute.
Because "operates" is a one-to-many relationship which means that each truck can only operated by 
one professional driver so a foreign key of truck that refers to a professional driver could represent
this relationship. "Drives" is a many-to-many relationship so I use a table to record which 
non professional driver drives which car.
*/