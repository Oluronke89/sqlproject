CREATE DATABASE Healthylifestyle

USE Healthylifestyle

CREATE TABLE Patients(
PatientID int primary key,
FirstName varchar(50) not null,
LastName varchar(50)  not null,
DateofBirth date not null,
Gender char(50) not null,
PostCode varchar(10) not null
);
---alter table Patients alter column Gender char(50)

SELECT * FROM Patients

CREATE TABLE Specialty(
SpecialtyCode varchar(20) primary key,
SpecialtyName varchar(50) not null,
DoctorName varchar(50) not null,
TreatmentFunction  varchar(70) not null
);
----alter table Speciality alter column SpecialityCode  varchar(20) primary key
SELECT * FROM Specialty



CREATE TABLE Practice(
GPPracticeCode varchar(20) Primary key,
PracticeName varchar(50) not null,
PracticePostCode varchar(50) not null
);
SELECT * FROM Practice



CREATE TABLE  MethodOfAdmission(
MethodOfAdmissionCode varchar(20) primary key,
MethodOfAdmissionType varchar(70) not null
);
SELECT * FROM MethodOfAdmission


CREATE TABLE  Wards(
WardCode varchar(50) primary key,
WardName varchar(70) not null,
WardType varchar(70) not null
);
----alter table Ward alter column WardCode varchar(50)
SELECT * FROM Wards


CREATE TABLE GP(
GPCode int primary key,
GPName varchar(70) not null,
GPPracticeCode varchar(20) foreign key(GPPracticeCode) references Practice(GPPracticeCode)
);
----drop table GP
SELECT  * FROM GP



CREATE TABLE Diagnosiss (
    DiagnosisCode varchar(20) primary key,
    DiagnosisDescription varchar(255) not null
);
select* from Diagnosiss


CREATE TABLE Patient_Diagnosis_ (
    DiagnosisCode varchar(20) foreign key references Diagnosiss(DiagnosisCode),
    AdmissionID int foreign key references Admission(AdmissionID)
	);
SELECT * FROM Patient_Diagnosis_


CREATE TABLE Admission(
AdmissionID int primary key,
DiagnosisCode varchar (20),
PatientID int,
LengthOfStay int,
AdmissionDate date,
DischargeDate date,
SpecialtyCode varchar(20),
WardCode varchar(50),
MethodOfAdmissionCode varchar(20),
GPPracticeCode varchar(20),
foreign key (PatientID) references Patients(PatientID),
foreign key (SpecialtyCode) references Specialty(SpecialtyCode),
foreign key (WardCode) references Wards(WardCode),
foreign key (MethodOfAdmissionCode) references MethodOfAdmission(MethodOfAdmissionCode),
foreign key (DiagnosisCode) references Diagnosiss(DiagnosisCode),
foreign key (GPPracticeCode) references Practice(GPPracticeCode)
);

select * from Admission


