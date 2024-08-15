# Healthylifehospitals Analysis
![hospital jpeg](https://github.com/user-attachments/assets/58c5e182-9152-44a1-ad10-7091076f0cdd)

## Table of Contents

- [Project Overview](#project-overview)
- [Database Creation](#database-creation)
- [Data Cleaning/Preparation](#data-Cleaning/Preparation)
- [Tools](#tools)
- [Exploratory Data Analysis](#exploratory-Data-Analysis)
- [Data Analysis](#data-Analysis)
- [Results](#results)
- [Recommendations](#recommendations)

### Project Overview

 This data analysis project aims to create a comprehensive database to manage patients admissions, diagnoses, wards and related information. This database will aid in analyzing patient admissions, undestanding common diagnoses, and optimizing hospital operations.

### Database Creation

the following steps were taken to achieve this:
- Database Creation
- Table Creation
- Entity-Relationship Diagram
- Populating tables,testing and validation
- Creating Views

  #### Database Creation
  
The database for the hospital was created using SQL Server.

```sql
CREATE DATABASE Healthylifestyle

USE Healthylifestyle
```
  
#### Table Creation

Nine tables for the hospital database were created, which includes:
-Patients 
-methodofadmission
-practice
-GP
-specialty
-admission
-Wards
-Diagnosiss
Patient_Diagnosis_


```sql
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
```
#### Entity Relationship Design

ER diagrams uses symbols to represent entities, attributes, and relationship, which help to illustrate relationships between entities in the database. Using SQL Server,ER diagram below was created. This diagram shows the relationship between the entities in the databases and also shows the table constraints that woukd be appropriate for the ER Diagram Design.

![image](https://github.com/user-attachments/assets/a73e86a6-9731-40b6-b654-e9593853009e)




#### Populating tables,testing and validation

Using the insert clause,values were populated into the hospital database using chatgpt. This helped to validate the relationship between the tables.

```sql
-- Insert 12 records into the MethodOfAdmission table
 insert into MethodOfAdmission values
    ('ELEC', 'Elective'),
    ('EMER', 'Emergency'),
    ('IP', 'Inpatient'),
    ('OP', 'Outpatient'),
    ('SURG', 'Surgical'),
    ('MAT', 'Maternity'),
    ('PED', 'Pediatric'),
    ('PSY', 'Psychiatric'),
    ('REHAB', 'Rehabilitation'),
    ('GP', 'General Practioner'),
    ('OBS', 'Observation'),
    ('NELE', 'NonElective'); 
	
-------------------------MethodOfAdmission End Here--------------------------------------------	
	
	;-- Insert 25 records into the Specialty table
INSERT INTO Specialty VALUES
('CAR', 'Cardiology', 'Dr. Smith', 'Heart disease treatment'),
('ORTH', 'Orthopedics', 'Dr. Johnson', 'Bone and joint disorders'),
('NEU', 'Neurology', 'Dr. Williams', 'Nervous system disorders'),
('ONC', 'Oncology', 'Dr. Brown', 'Cancer treatment'),
('PED', 'Pediatrics', 'Dr. Miller', 'Medical care for children'),
('DERM', 'Dermatology', 'Dr. Wilson', 'Skin disorders treatment'),
('GAST', 'Gastroenterology', 'Dr. Moore', 'Digestive system disorders'),
('ENDO', 'Endocrinology', 'Dr. Taylor', 'Endocrine disorders treatment'),
('URO', 'Urology', 'Dr. Anderson', 'Urinary system disorders'),
('OPHT', 'Ophthalmology', 'Dr. Thomas', 'Eye disorders treatment'),
('PSYC', 'Psychiatry', 'Dr. Martinez', 'Mental health treatment'),
('PULM', 'Pulmonology', 'Dr. Garcia', 'Respiratory disorders treatment'),
('RHEU', 'Rheumatology', 'Dr. Rodriguez', 'Autoimmune disorders treatment'),
('HEAM', 'Hematology', 'Dr. Hernandez', 'Blood disorders treatment'),
('NEPH', 'Nephrology', 'Dr. Gonzalez', 'Kidney disorders treatment'),
('INF', 'Infectious Diseases', 'Dr. Perez', 'Infectious diseases treatment'),
('IMMUN', 'Allergy and Immunology', 'Dr. Flores', 'Allergy and immune system disorders'),
('ALL', 'Physical Medicine and Rehabilitation', 'Dr. Sanchez', 'Rehabilitation treatment'),
('GER', 'Geriatrics', 'Dr. Ramirez', 'Care for elderly patients'),
('ANES', 'Anesthesiology', 'Dr. Torres', 'Anesthesia and pain management'),
('EMERG', 'Emergency Medicine', 'Dr. Ortiz', 'Emergency medical care'),
('FAM', 'Family Medicine', 'Dr. Cruz', 'Comprehensive primary care'),
('INM', 'Internal Medicine', 'Dr. Reyes', 'Internal diseases treatment'),
('RAD', 'Radiology', 'Dr. Vega', 'Diagnostic imaging and radiation therapy'),
('PATH', 'Pathology', 'Dr. Morales', 'Disease diagnosis and laboratory testing'),
('GYN','Gyneacology', 'Dr. Wales','childbirth/delivery'),
('ENT','Ear,Nose and Throat','Dr.Rice',' Ear,nose and throat disorder');

-------------------------Specialty End Here---------------------------------------------

-- Insert 50 records into the Wards table
insert into Wards values
    ('W001', 'North Wing', 'General'),
    ('W002', 'South Wing', 'Surgical'),
    ('W003', 'East Wing', 'Pediatric'),
    ('W004', 'West Wing', 'Maternity'),
    ('W005', 'A1', 'ICU'),
    ('W006', 'B2', 'Cardiology'),
    ('W007', 'C3', 'Neurology'),
    ('W008', 'D4', 'Orthopedics'),
    ('W009', 'E5', 'Oncology'),
    ('W010', 'F6', 'Rehabilitation'),
    ('W011', 'G7', 'Endoscopy Suite'),
    ('W012', 'H8', 'Pulmonology'),
    ('W013', 'I9', 'Endoscopy Suite'),
    ('W014', 'J10', 'Dermatology'),
    ('W015', 'K11', 'Infectious Diseases'),
    ('W016', 'L12', 'Rheumatology'),
    ('W017', 'M13', 'Urology'),
    ('W018', 'N14', 'Ophthalmology'),
    ('W019', 'O15', 'Ear, Nose, and Throat'),
    ('W020', 'P16', 'Hematology'),
    ('W021', 'Q17', 'Allergy and Immunology'),
    ('W022', 'R18', 'Anesthesiology'),
    ('W023', 'S19', 'Radiology'),
    ('W024', 'T20', 'Pathology'),
    ('W025', 'U21', 'Day Surgery'),
    ('W026', 'V22', 'Observation'),
    ('W027', 'W23', 'Long-term Care'),
    ('W028', 'X24', 'Maternity'),
    ('W029', 'Y25', 'Psychiatric'),
    ('W030', 'Z26', 'Surgical'),
    ('W031', 'AA27', 'General'),
    ('W032', 'BB28', 'Pediatric'),
    ('W033', 'CC29', 'Maternity'),
    ('W034', 'DD30', 'ICU'),
    ('W035', 'EE31', 'Cardiology'),
    ('W036', 'FF32', 'Neurology'),
    ('W037', 'GG33', 'Orthopedics'),
    ('W038', 'HH34', 'Oncology'),
    ('W039', 'II35', 'Rehabilitation'),
    ('W040', 'JJ36', 'Endoscopy Suite'),
    ('W041', 'KK37', 'Pulmonology'),
    ('W042', 'LL38', 'Endoscopy Suite'),
    ('W043', 'MM39', 'Dermatology'),
    ('W044', 'NN40', 'Infectious Diseases'),
    ('W045', 'OO41', 'Rheumatology'),
    ('W046', 'PP42', 'Urology'),
    ('W047', 'QQ43', 'Ophthalmology'),
    ('W048', 'RR44', 'Ear, Nose, and Throat'),
    ('W049', 'SS45', 'Hematology'),
    ('W050', 'TT46', 'Allergy and Immunology');
-------------------------Ward End Here---------------------------------------------

	

-- Insert 25 records into the GP table
insert into GP values
(01, 'Dr. Smith', 'GP001'),
(02, 'Dr. Johnson', 'GP002'),
(03, 'Dr. Williams','GP003'),
(04, 'Dr. Brown','GP004'),
(05, 'Dr. Miller','GP005'),
(06,  'Dr. Wilson', 'GP006'),
(07,  'Dr. Moore', 'GP007'),
(08,  'Dr. Taylor', 'GP008'),
(09, 'Dr. Anderson', 'GP009'),
(10, 'Dr. Thomas', 'GP010'),
(11,  'Dr. Martinez','GP011'), 
(12,  'Dr. Garcia', 'GP012'),
(13,  'Dr. Rodriguez', 'GP013'),
(14,  'Dr. Hernandez','GP014'),
(15,  'Dr. Gonzalez','GP015'),
(16,  'Dr. Perez','GP016'),
(17, 'Dr. Flores','GP017'),
(18, 'Dr. Sanchez','GP018'),
(19,  'Dr. Ramirez','GP019'),
(20, 'Dr. Torres','GP020'),
(21,  'Dr. Ortiz','GP021'),
(22, 'Dr. Cruz', 'GP022'),
(23, 'Dr. Reyes','GP023'),
(24, 'Dr. Vega', 'GP024'),
(25, 'Dr. Morales','GP025');
-------------------------GP End Here---------------------------------------------



-- Insert 25 records into the Practice table
	insert into Practice values
    ('GP001', 'HealthFirst Clinic', 'AB12 3CD'),
    ('GP002', 'Wellness Medical Center', 'BC23 4DE'),
    ('GP003', 'CityCare GP Practice', 'CD34 5EF'),
    ('GP004', 'Greenfield Health', 'DE45 6FG'),
    ('GP005', 'Pinewood Medical', 'EF56 7GH'),
    ('GP006', 'Riverdale Clinic', 'FG67 8HI'),
    ('GP007', 'UrbanCare Practice', 'GH78 9IJ'),
    ('GP008', 'BrightHealth Center', 'HI89 0JK'),
    ('GP009', 'Central GP Clinic', 'IJ90 1KL'),
    ('GP010', 'Northview Medical', 'JK01 2LM'),
    ('GP011', 'Southside Health', 'KL12 3NO'),
    ('GP012', 'Westfield Practice', 'LM23 4OP'),
    ('GP013', 'Eastwood Medical Center', 'MN34 5PQ'),
    ('GP014', 'Village Health Clinic', 'NO45 6QR'),
    ('GP015', 'Main Street GP', 'OP56 7RS'),
    ('GP016', 'Sunrise Clinic', 'PQ67 8ST'),
    ('GP017', 'HealthPlus Practice', 'QR78 9TU'),
    ('GP018', 'FamilyCare Medical', 'RS89 0UV'),
    ('GP019', 'Oakwood GP Practice', 'ST90 1WX'),
    ('GP020', 'Harmony Health Center', 'TU01 2XY'),
('GP021', 'Riverdale Health Centre', 'EF34 5GH'),
('GP022', 'Hilltop Surgery', 'IJ56 7KL'),
('GP023', 'Sunset Medical Practice', 'MN78 9OP'),
('GP024', 'Valley View Clinic', 'QR90 1ST'),
('GP025', 'Maple Grove Surgery', 'UV23 4WX');
-------------------------Practice End Here---------------------------------------------

-- Insert 50 records into the Diagnosiss table
INSERT INTO Diagnosiss VALUES
    ('I10', 'Essential (primary) hypertension'),
    ('E11', 'Type 2 diabetes mellitus'),
    ('J45', 'Asthma'),
    ('I25', 'Chronic ischemic heart disease'),
    ('M54', 'Dorsalgia'),
    ('E66', 'Obesity'),
    ('F41', 'Other anxiety disorders'),
    ('J06', 'Acute upper respiratory infections'),
    ('I50', 'Heart failure'),
    ('N18', 'Chronic kidney disease'),
    ('M81', 'Osteoporosis without current pathological fracture'),
    ('K21', 'Gastro-esophageal reflux disease'),
    ('J44', 'Chronic obstructive pulmonary disease'),
    ('F32', 'Major depressive disorder, single episode'),
    ('L20', 'Atopic dermatitis'),
    ('I63', 'Cerebral infarction'),
    ('E78', 'Disorders of lipoprotein metabolism and other lipidemias'),
    ('M17', 'Osteoarthritis of knee'),
    ('G47', 'Sleep disorders'),
    ('K52', 'Other and unspecified noninfective gastroenteritis and colitis'),
    ('N39', 'Other disorders of urinary system'),
    ('J18', 'Pneumonia, organism unspecified'),
    ('F33', 'Major depressive disorder, recurrent'),
    ('G43', 'Migraine'),
    ('M79', 'Other and unspecified soft tissue disorders'),
    ('R51', 'Headache'),
    ('K04', 'Diseases of pulp and periapical tissues'),
    ('B34', 'Viral infection of unspecified site'),
    ('H52', 'Disorders of refraction and accommodation'),
    ('M25', 'Other joint disorder, not elsewhere classified'),
    ('R10', 'Abdominal and pelvic pain'),
    ('L30', 'Other and unspecified dermatitis'),
    ('I48', 'Atrial fibrillation and flutter'),
    ('N40', 'Benign prostatic hyperplasia'),
    ('J30', 'Vasomotor and allergic rhinitis'),
    ('E03', 'Other hypothyroidism'),
    ('M16', 'Osteoarthritis of hip'),
    ('K29', 'Gastritis and duodenitis'),
    ('F20', 'Schizophrenia'),
    ('I21', 'Acute myocardial infarction'),
    ('L40', 'Psoriasis'),
    ('J35', 'Chronic diseases of tonsils and adenoids'),
    ('N20', 'Calculus of kidney and ureter'),
    ('K59', 'Other functional intestinal disorders'),
    ('G40', 'Epilepsy and recurrent seizures'),
    ('M51', 'Thoracic, thoracolumbar, and lumbosacral intervertebral disc disorders'),
    ('E55', 'Vitamin D deficiency'),
    ('I73', 'Other peripheral vascular diseases'),
    ('N95', 'Menopausal and other perimenopausal disorders'),
    ('E27', 'Other disorders of adrenal gland'),
	('G45', 'Cataract');
-------------------------Diagnosis End Here---------------------------------------------
```

### Creating View

A view is a virtual table which is derived from the original tables which helps to access the needed columns easily without having to query all tables again. View template was created to evaluate the GPPractice performance

```sql
 --Create View
 CREATE VIEW GPPractice
 AS
 SELECT TOP 1 
Practice.PracticeName, 
COUNT(*) AS NoOfAdmission
FROM Admission A
JOIN Practice
ON A.GPPracticeCode = Practice.GPPracticeCode
JOIN MethodOfAdmission M 
ON M.MethodOfAdmissionCode = A.MethodOfAdmissionCode
WHERE YEAR( AdmissionDate ) IN (2015,2016)
AND M.MethodOfAdmissionCode = 'GP'
GROUP BY Practice.PracticeName
ORDER BY NoOfAdmission DESC;

---Confirm the Created View
select * from GPPractice
```

### Tools

- Chatgpt -Populating Data
- SQL Server-Data Analysis

  ### Exploratory Data Analysis
 
EDA involved exploring the dataset to answer the following questions:

-Top 5 specialty with the highest numbers od admissions in year 2015/2016
-GP with the most patients admitted to the hospital in year 2015/2016
- GP Practice was responsible for the largest number of hospital admission episodes
-  Total number of admissions for each ward in 2015/2016
-  Total number of admissions per patient
-  Average length of stay for all admissions in each ward for the year 2015/2016


### Data Analysis

include some interesting code worked with

```sql
---Retrieve the total number of admissions per patient.

SELECT PatientID, COUNT(*) AS TotalAdmissions
FROM Admission
GROUP BY PatientID;
select * from patients
where gender ="female";

----Retrieve the total number of admissions for each ward in the financial year 2015/16.

SELECT WardCode, COUNT(*) AS TotalAdmissions
FROM Admission
WHERE  YEAR(DischargeDate) IN (2015, 2016)
GROUP BY WardCode;

---For hospital admissions with an admission date in the financial year 2015/16 (01/04/2015 to 31/03/2016), which GP Practice was responsible for the largest number of hospital admission episodes with a method of admission of GP?

SELECT TOP 1 
Practice.PracticeName, 
COUNT(*) AS NoOfAdmission
FROM Admission A
JOIN Practice
ON A.GPPracticeCode = Practice.GPPracticeCode
JOIN MethodOfAdmission M 
ON M.MethodOfAdmissionCode = A.MethodOfAdmissionCode
WHERE YEAR( AdmissionDate ) IN (2015,2016)
AND M.MethodOfAdmissionCode = 'GP'
GROUP BY Practice.PracticeName
ORDER BY NoOfAdmission DESC;

---Retrieve the list of all patients who had more than one admission in the financial year 2015/16.
	
	SELECT 
    PatientID,
    COUNT(*) AS AdmissionCount
FROM 
    Admission
WHERE 
    YEAR(AdmissionDate) IN (2015, 2016)
GROUP BY 
    PatientID
HAVING 
    COUNT(*) > 1;


	
----Calculate the average length of stay for all admissions in each ward for the financial year 2015/16.

	SELECT 
    WardCode,
    AVG(DATEDIFF(day, AdmissionDate, DischargeDate)) AS AverageLengthOfStay
FROM 
    Admission
WHERE 
    YEAR(AdmissionDate) IN (2015, 2016)
    AND YEAR(DischargeDate) IN (2015, 2016)
GROUP BY 
    WardCode;
	
	
	
	
	
	-----List the top 5 specialties with the highest number of admissions in the financial year 2015/16.


	SELECT TOP 5
    SpecialtyCode,
    COUNT(*) AS AdmissionCount
FROM 
    Admission
WHERE 
    YEAR(AdmissionDate) IN (2015, 2016)
GROUP BY 
    SpecialtyCode
ORDER BY 
    AdmissionCount DESC;


	
	----Find the GP with the most patients admitted to the hospital in the financial year 2015/16.
 WITH PatientAdmissions AS (
    SELECT 
        a.PatientID,
        a.GPPracticeCode
    FROM 
        Admission a
    WHERE 
      YEAR ( a.AdmissionDate) IN (2015,2016) 
    GROUP BY 
        a.PatientID, a.GPPracticeCode
),
GPPatientCounts AS (
    SELECT
        p.GPPracticeCode,
        g.GPName,
        COUNT(DISTINCT p.PatientID) AS PatientCount
    FROM
        PatientAdmissions p
    JOIN
        GP g
        ON p.GPPracticeCode = g.GPPracticeCode
    GROUP BY
        p.GPPracticeCode, g.GPName
)
SELECT
Top 1
    GPName,
    PatientCount
FROM
    GPPatientCounts
ORDER BY 
PatientCount DESC;
```

### Results

The analysis results are summarized as follows:

- DR Garcia was the GP with the most patients admitted to the hospital in the year 2015/2016.
- The top 5 specialty includes Dermatology, Cardiology, Urology, Orthopedic and Gynaecology.
-  Average length of stay in each ward is between 3-7 days.
-  Greenfield Health is the GP Practice responsible for the highest number of hospital admission episodes with a method of admission of GP

### Recommedations

I recommend that hospitals should keep the length of stay down as well as the associated costs, so that more patients can be addmitted if there ia a bed available for them.
