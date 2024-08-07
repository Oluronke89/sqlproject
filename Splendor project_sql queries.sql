
QUESTION 1
---List all patients with their details (ID, Name, Gender, Date of Birth, Postcode).

SELECT
PatientID,
FirstName,
LastName,
Gender,
Dateofbirth,
PostCode
FROM Patients



                (b)
---Retrieve the total number of admissions per patient.

SELECT PatientID, COUNT(*) AS TotalAdmissions
FROM Admission
GROUP BY PatientID;

QUESTION 2
                   2(a)
----For hospital admissions with a discharge date in the financial year 2014/15 (01/04/2014 to 31/03/2015), find the maximum length of stay where the admission ward was the Endoscopy Suite, and the method of admission type was Elective.

 SELECT
  w.WardType,
  ma.MethodOfAdmissionType,
  MAX(DATEDIFF(day, AdmissionDate, DischargeDate)) AS MaxLengthOfStay
FROM Admission a
INNER JOIN Wards w ON a.WardCode = w.WardCode
INNER JOIN MethodOfAdmission ma ON a.MethodOfAdmissionCode = ma.MethodOfAdmissionCode
WHERE  YEAR(DischargeDate) IN (2015, 2016)
  AND WardType = 'Endoscopy Suite'
  AND MethodOfAdmissionType = 'Elective'
  group by
  WardType,MethodOfAdmissionType;


                (b)
----Retrieve the total number of admissions for each ward in the financial year 2015/16.

SELECT WardCode, COUNT(*) AS TotalAdmissions
FROM Admission
WHERE  YEAR(DischargeDate) IN (2015, 2016)
GROUP BY WardCode;


QUESTION 3
(a)
---	What was the most common primary diagnosis (include the code and description) for hospital admission episodes where the discharge date was in the financial year 2015/16 (01/04/2015 to 31/03/2016), the method of admission type was Emergency, and the patient lived in the SK2 postcode area?

 SELECT TOP 1 
    d.DiagnosisCode AS PrimaryDiagnosisCode,
	 dia.DiagnosisDescription AS PrimaryDiagnosisDescription,
      COUNT(*) AS DiagnosisCount
FROM 
    Admission a
JOIN 
    Patients p ON a.PatientID = p.PatientID
JOIN 
    Patient_Diagnosis_ d ON a.AdmissionID = d.AdmissionID
	INNER JOIN Diagnosiss dia ON d.DiagnosisCode=dia.DiagnosisCode
WHERE
 YEAR(DischargeDate) in (2015,2016)
    AND a.MethodOfAdmissionCode = (SELECT MethodOfAdmissionCode FROM MethodOfAdmission WHERE MethodOfAdmissionType  = 'Emergency')
    AND p.Postcode LIKE 'SK2%'  -- Assuming postcode area 'SK2'
GROUP BY 
    d.DiagnosisCode ,dia.DiagnosisDescription
ORDER BY 
    DiagnosisCount DESC;
  
  
  (b)
  ---	For hospital admissions with a discharge date in the financial year 2015/16 (01/04/2015 to 31/03/2016), what was the primary diagnosis (include the code and description) that resulted in the longest average length of stay where the method of admission type was Emergency or NonElective, and there were at least 100 hospital admission episodes with that primary diagnosis?
 
 
 SELECT TOP 1
	 d.DiagnosisCode AS PrimaryDiagnosisCode,
	 dia.DiagnosisDescription AS PrimaryDiagnosisDescription,
	 m.MethodOfAdmissionCode,
 AVG(DATEDIFF(day, AdmissionDate, DischargeDate)) AS AverageLengthOfStay,
 COUNT(*) AS AdmissionCount
 FROM Admission a
 JOIN 
    Patient_Diagnosis_ d ON a.AdmissionID = d.AdmissionID
	INNER JOIN MethodOfAdmission m ON m.MethodOfAdmissionCode=a.MethodOfAdmissionCode
	INNER JOIN Diagnosiss dia ON d.DiagnosisCode=dia.DiagnosisCode
    WHERE
	YEAR(DischargeDate) IN (2015,2016)
	and MethodOfAdmissionType IN ('Emergency', 'NonElective')
      GROUP BY
	   d.DiagnosisCode,
	   dia.DiagnosisDescription,
	   m.MethodOfAdmissionCode
	   HAVING
    COUNT(*) >= 25
ORDER BY 
    AverageLengthOfStay DESC;

	

	QUESTION 4

	----For hospital admissions with an admission date in the financial year 2015/16 (01/04/2015 to 31/03/2016), which GP Practice was responsible for the largest number of hospital admission episodes with a method of admission of GP?

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




	QUESTION 5
	(a)

	----The admission date (2nd episode) is within 7 days of a discharge date (1st episode) where the PatientID is the same, but the AdmissionID is different.	The admission date (2nd episode) is within 7 days of a discharge date (1st episode) where the PatientID is the same, but the AdmissionID is different.
SELECT 
    A1.AdmissionID AS FirstAdmissionID,
    A1.PatientID,
    A1.AdmissionDate AS FirstAdmissionDate,
    A1.DischargeDate AS FirstDischargeDate,
    A2.AdmissionID AS SecondAdmissionID,
    A2.AdmissionDate AS SecondAdmissionDate
FROM  Admission A1
JOIN Admission A2 
ON A1.PatientID = A2.PatientID
WHERE  A1.AdmissionID <> A2.AdmissionID
AND A2.AdmissionDate BETWEEN DATEADD(day, 1, A1.DischargeDate) AND DATEADD(day, 7, a1.DischargeDate)
ORDER BY 
A1.AdmissionID;


      (b)	
	 --- The admission date of the 2nd episode is after the discharge date of the 1st episode.
---The method of admission type of the 1st episode is Elective, and the method of admission type of the 2nd episode is Emergency.
---The specialty code of both admission episodes is the same

	SELECT 
    a1.PatientID,
    a1.AdmissionID AS FirstAdmissionID,
    a1.AdmissionDate AS FirstAdmissionDate,
    a1.DischargeDate AS FirstDischargeDate,
    a2.AdmissionID AS SecondAdmissionID,
    a2.AdmissionDate AS SecondAdmissionDate
FROM 
    Admission a1
JOIN 
    Admission a2
    ON a1.PatientID = a2.PatientID
    AND a1.AdmissionID <> a2.AdmissionID
    AND a2.AdmissionDate > a1.DischargeDate
order by
a1.AdmissionID

SELECT 
    A1.AdmissionID AS FirstAdmissionID,
    A1.PatientID,
    A1.AdmissionDate AS FirstAdmissionDate,
    A1.DischargeDate AS FirstDischargeDate,
    A2.AdmissionID AS SecondAdmissionID,
    A2.AdmissionDate AS SecondAdmissionDate
FROM  Admission A1
JOIN Admission A2 
ON A1.PatientID = A2.PatientID
WHERE  A1.AdmissionID <> A2.AdmissionID
AND A2.AdmissionDate BETWEEN DATEADD(day, 1, A1.DischargeDate) AND DATEADD(day, 7, a1.DischargeDate)
ORDER BY 
A1.AdmissionID;


  (c)
 ---- The method of admission type of the 1st episode is Elective, and the method of admission type of the 2nd episode is Emergency.
  SELECT 
    a1.PatientID,
    a1.AdmissionID AS FirstAdmissionID,
    a1.AdmissionDate AS FirstAdmissionDate,
    a1.DischargeDate AS FirstDischargeDate,
    a1.MethodOfAdmissionCode AS FirstAdmissionMethod,
    a2.AdmissionID AS SecondAdmissionID,
    a2.AdmissionDate AS SecondAdmissionDate,
    a2.MethodOfAdmissionCode AS SecondAdmissionMethod
FROM 
    Admission a1
JOIN 
    Admission a2
    ON a1.PatientID = a2.PatientID
    AND a1.AdmissionID <> a2.AdmissionID
    AND a1.MethodOfAdmissionCode = 'ELEC'
    AND a2.MethodOfAdmissionCode = 'EMER'
    AND a2.AdmissionDate > a1.DischargeDate
	ORDER BY 
    a1.AdmissionID;

	(d)
	----The specialty code of both admission episodes is the same
	SELECT 
    a1.PatientID,
    a1.AdmissionID AS FirstAdmissionID,
    a1.AdmissionDate AS FirstAdmissionDate,
    a1.DischargeDate AS FirstDischargeDate,
    a1.specialtyCode AS FirstSpecialtyCode,
    a2.AdmissionID AS SecondAdmissionID,
    a2.AdmissionDate AS SecondAdmissionDate,
    a2.specialtyCode AS SecondSpecialtyCode
FROM 
    Admission a1
JOIN 
    Admission a2
    ON a1.PatientID = a2.PatientID
    AND a1.AdmissionID <> a2.AdmissionID
    AND a1.specialtyCode = a2.specialtyCode
	ORDER BY 
    a1.AdmissionID;


              QUESTION 6(a)
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


	
	


	(b)
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
	
	
	
	
	(c)
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


	(d)
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


 
(e)
----	Retrieve the list of all patients who were admitted to the ICU ward and their corresponding diagnoses.
SELECT 
    a.PatientID,
	b.WardType,
    d.DiagnosisCode,
	 dia.DiagnosisDescription 
FROM 
    Admission a
JOIN 
    Patient_Diagnosis_ d ON a.AdmissionID = d.AdmissionID
INNER JOIN Diagnosiss dia ON d.DiagnosisCode=dia.DiagnosisCode
JOIN
	Wards b ON b.WardCode=a.WardCode
WHERE 
     WardType = 'ICU' 




	
	