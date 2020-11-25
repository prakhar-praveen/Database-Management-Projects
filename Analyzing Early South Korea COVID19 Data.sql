# Create a table called PatientInfo 
CREATE TABLE PatientInfo(patient_id BIGINT, //ID of the patient.
                         global_num INTEGER, //The number given by the KCDC
                         gender CHAR(50),
                         birth_year INTEGER,
                         age INTEGER,
                         country CHAR(50),
                         province CHAR(50),
                         city CHAR(50),
                         disease CHAR(50),
                         infection_case CHAR(100),
                         infection_order INTEGER,
                         infected_by BIGINT,
                         contact_number INTEGER,
                         symptom_onset_date DATE,
                         confirmed_date DATE,
                         released_date DATE,
                         deceased_date DATE,
                         state CHAR(20)
                         );

# Create a few queries on this table */
# Find the number of patients from PatientInfo


SELECT COUNT (*) AS number_of_patients
FROM PatientInfo;

# Find the number of patients genderwise, i.e. number of male patients and female patients


SELECT P.gender, COUNT(*) AS number_g
FROM PatientInfo P
GROUP BY P.gender;

# Find the number of patients province-wise



SELECT P.province, COUNT(*) AS number_p
FROM PatientInfo P
GROUP BY P.province;

# Find the number of patients age-group-wise

 
SELECT COUNT(*) AS number_patients
FROM PatientsInfo P
WHERE P.age >= 0 AND P.age < 10;


SELECT COUNT(*) AS number_patients
FROM PatientInfo P
WHERE P.age >= 10 AND P.age < 20;


SELECT COUNT(*) AS number_patients
FROM PatientInfo P
WHERE P.age >= 20 AND P.age < 30;


SELECT COUNT(*) AS number_patients
FROM PatientInfo P
WHERE P.age >= 30 AND P.age < 40;


SELECT COUNT(*) AS number_patients
FROM PatientInfo P
WHERE P.age >= 40 AND P.age < 50;


SELECT COUNT(*) AS number_patients
FROM PatientInfo P
WHERE P.age >= 50 AND P.age < 60;


SELECT COUNT(*) AS number_patients
FROM PatientInfo P
WHERE P.age >= 60 AND P.age < 70;


SELECT COUNT(*) AS number_patients
FROM PatientInfo P
WHERE P.age >= 70 AND P.age < 80;


SELECT COUNT(*) AS number_patients
FROM PatientInfo P
WHERE P.age >= 80 AND P.age < 90;

SELECT COUNT(*) AS number_patients
FROM PatientInfo P
WHERE P.age >= 90 AND P.age < 100;


SELECT COUNT(*) AS number_patients
FROM PatientInfo P
WHERE P.age >= 100 AND P.age < 110;

# Find the number of patients for each type of infection_case

SELECT P.infection_case, COUNT(*) AS number_patients
FROM PatientInfo P
GROUP BY P.infection_case;

# Find the number of patients infection-order-wise

SELECT P.infection_order, COUNT(*) AS number_patients
FROM PatientInfo P
GROUP BY P.infection_order;

# Find the patients who are natives of S. Korea and got infected of infection_order = 1

SELECT P.patient_id
FROM PatientInfo P
WHERE P.country = 'Korea'
        AND P.patient_id IN(SELECT P2.patient_id
                            FROM PatientInfo P2
                            WHERE P2.infection_order = 1);
                            
# Find the patients who belong to age group 50 -109 and could not recover, i.e. were deceased
SELECT P.patient_id
FROM PatientInfo P
WHERE P.age >= 50 AND P.age <=109
            AND P.state = 'deceased';
            
# Find the patients who belong to age group 20-49 and were deceased


SELECT P.patient_id
FROM PatientInfo P
WHERE P.age >= 20 AND P.age <=49
            AND P.state = 'deceased';

# Find the patients who belong to age group 0-19 and were deceased

SELECT P.patient_id
FROM PatientInfo P
WHERE P.age >= 0 AND P.age <=19
            AND P.state = 'deceased';
            
# Find the patients who got infected from some patient who transmitted to maximum number of patients, along with the source patient.

SELECT P2.patient_id, P.patient_id
FROM PatientInfo P, PatientInfo P2
WHERE P.patient_id = P2.infected_by
        AND P.contact_number = (SELECT MAX (P3.contact_number) FROM PatientInfo P3)
        ;
        

# Find average number of transmssions from infected patients from among those who transmitted through contact
SELECT AVG(P.contact_number) AS avgnumber 
FROM PatientInfo P
WHERE P.contact_number > 0;

# Find the number of cases statewise (released/isolated/deceased)

SELECT P.state, COUNT(*) AS number_s
FROM PatientInfo P
GROUP BY P.state;

# FInd the number of patients who had underlying disease and got released

SELECT COUNT(*) AS number 
FROM PatientInfo P
WHERE P.disease = 'TRUE';

# Find the number of patients who were asymptomatic and isolated

SELECT COUNT(*) AS a_isolated
FROM PatientInfo P
WHERE P.symptom_onset_date IS NULL;

# Find the number of patients who were isolated before transmitting to others
SELECT COUNT (*) AS number
FROM PatientInfo P
WHERE P.contact_number IS NULL 
                AND P.state = 'isolated';
                
# Find the number of cases city wise
SELECT P.city, COUNT(*) AS number 
FROM PatientInfo P
GROUP BY P.city;

# Find the number of patients birth-year wise

SELECT P.birth_year, COUNT(*) AS number 
FROM PatientInfo P
GROUP BY P.birth_year;

# Find the patients whose infection case is overseas inflow
SELECT P.patient_id
FROM PatientInfo P
WHERE P.infection_case = 'overseas inflow';

# Find the patients whose infection case is contact with patient
SELECT P.patient_id
FROM PatientInfo P
WHERE P.infection_case = 'contact with patient';

# Find the patients who were symptomatic, still were released

SELECT P.patient_id
FROM PatientInfo P
WHERE P.symptom_onset_date IS NOT NULL
        AND P.state = 'released';
