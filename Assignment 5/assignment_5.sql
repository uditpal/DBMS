DROP DATABASE IF EXISTS Hospital;
CREATE DATABASE Hospital;
USE Hospital;

DROP TABLE IF EXISTS Doctor;
CREATE TABLE Doctor (
	Doc_id INT NOT NULL,
	Doc_first_name VARCHAR(20) NOT NULL,
    Doc_last_name VARCHAR(20) NOT NULL,
    Doc_mobile VARCHAR(50) NULL DEFAULT NULL,
    Doc_specialization VARCHAR(45) NOT NULL,
    Doc_salary INT NULL DEFAULT NULL,
    Doc_address VARCHAR(255) NULL DEFAULT NULL,
    PRIMARY KEY (Doc_id)
    );

DROP TABLE IF EXISTS Patient;
CREATE TABLE Patient (
	P_id INT NOT NULL,
	P_first_name VARCHAR(20) NOT NULL,
    P_last_name VARCHAR(20) NOT NULL,
    P_dob DATE NOT NULL,
    P_mobile VARCHAR(50) NULL DEFAULT NULL,
    P_address VARCHAR(255) NOT NULL,
    P_insurence VARCHAR(255),
    Doc_id INT NOT NULL,
    PRIMARY KEY (P_id),
    CONSTRAINT fkDoctorPatients FOREIGN KEY (Doc_id) REFERENCES Doctor (Doc_id) ON DELETE RESTRICT ON UPDATE CASCADE
    );
    
DROP TABLE IF EXISTS Medical_Record;   
CREATE TABLE Medical_Record (
	P_problem VARCHAR(20) NULL DEFAULT NULL,
    Date_of_examination DATETIME NULL DEFAULT NULL,
    P_id INT NOT NULL,
    CONSTRAINT fKPatientRecord FOREIGN KEY (P_id) REFERENCES Patient (P_id) ON DELETE RESTRICT ON UPDATE CASCADE
    );

DROP TABLE IF EXISTS Room;   
CREATE TABLE Room (
	Room_id INT NOT NULL,
    Room_period DATETIME NULL DEFAULT NULL,
    Room_type VARCHAR(20) NOT NULL,
    P_id INT NOT NULL,
    PRIMARY KEY (Room_id),
    CONSTRAINT fKPatientRoom FOREIGN KEY (P_id) REFERENCES Patient (P_id) ON DELETE RESTRICT ON UPDATE CASCADE
    );

insert into Room
values
(200,null, "ICU", 1),
(201,null,"Single Bed", 2),
(202,null, "Isolation Room", 3),
(203,null, "ICU", 4);

select * from Room;
    
DROP TABLE IF EXISTS Medicine;   
CREATE TABLE Medicine (
	Medi_id INT NOT NULL,
	Medi_quantity INT NULL DEFAULT NULL,
    Medi_price int NOT NULL,
    P_id INT NOT NULL,
    PRIMARY KEY (Medi_id),
    CONSTRAINT fKPatientMedi FOREIGN KEY (P_id) REFERENCES Patient (P_id) ON DELETE RESTRICT ON UPDATE CASCADE
    );
    
    insert into Medicine
    values
    (300,4,1000,1),
    (301,2,100,1),
    (302,1,200,2),
    (303,3,500,5);
    
    select * from Medicine;

DROP TABLE IF EXISTS Nurse;    
CREATE TABLE Nurse (
	N_id INT NOT NULL,
    N_name VARCHAR(45) NOT NULL,
    N_mobile VARCHAR(55) DEFAULT NULL,
    N_dob DATE NOT NULL,
    Room_id INT NOT NULL,
    PRIMARY KEY (N_id),
    CONSTRAINT fKRoomNurse FOREIGN KEY (Room_id) REFERENCES Room (Room_id) ON DELETE RESTRICT ON UPDATE CASCADE
    );
    
INSERT INTO Doctor
VALUES
(101, 'Ajit','Sharma', 7788498482, 'Cardiologist', 542135,null),
(102, 'Ramesh','kumar', 6027849494, 'Audiologist', 5441235, 'Chennai');

SELECT * FROM Doctor;
-- ALTER TABLE Doctor add Doc_name VARCHAR(40) as  (concat(Doc_first_name, ' ',Doc_last_name));



INSERT INTO Patient
VALUES
(1, 'Rahul','Raj', '1978-05-27', 6045218763, 'Bihar', 'qwertyuiop', 102),
(2, 'Ramesh','Athe', '1999-11-01', 7740562398, 'Delhi', 'asdfghjkl', 101);

-- ALTER TABLE Patient add P_name VARCHAR(40) as  (concat(P_first_name, ' ',P_last_name));

-- DROP TABLE Room;

SELECT * FROM Patient;

SELECT * FROM Doctor;


INSERT INTO Doctor
VALUES
(103, 'Pavan', 'Sharma', 7788400050, 'ENT', 542135,'Delhi'),
(104, 'Rajendra' ,'Verma', 60226249494, 'Medicine', 544135, 'Bangalore');

INSERT INTO Doctor
VALUES
(105,'John','Wick', 0123456789, 'Medicine', 1234, 'Kolkata'),
(106,'Iron','Man',9876543210,'ENT',786,'IIIT Dharwad');

-- drop table Patient;
INSERT INTO Patient
VALUES
(3, 'Rajendra','Raj', '1958-05-27', 6045218763, 'Hubli', 'qwertyuiop', 103),
(4, 'Ramesh','Athe', '1999-11-01', 7740562398, 'Dharwad', 'asdfghjkl', 104),
(5, 'Sunil','Ravula', '1947-05-27', 60155218763, 'Patna', 'qwertyuiop', 103),
(6, 'Rajesh','Kumar', '1999-11-01', 7740562398, 'Delhi', 'asdfghjkl', 104),
(7, 'Advay','Aggarwal', '2018-05-27', 6045218763, 'Ooty', 'qwertyuiop', 103),
(8, 'Mithil','Anchan', '1999-11-01', 7740562398, 'Mumbai', 'asdfghjkl', 104),
(9, 'Akash','Kumar', '1989-05-27', 6045218763, 'Manali', 'qwertyuiop', 103),
(10, 'Kshitiz','Michael', '1940-11-01', 7740562398, 'Srinagar', 'asdfghjkl', 103);

SELECT * FROM Patient ORDER BY P_dob;

SELECT Doc_id as Doctor_Id, count(P_id) as NumberOfPatients FROM Patient group by Doc_id;

-- SELECT * From Doctor where
-- Doc_id = (SELECT P.Doc_id, max(P.NumberOfPatients) from (select Doc_id , count(P_id) as NumberOfPatients from Patient group by Doc_id) P);
use Hospital;
SELECT avg(Doc_salary), Doc_specialization FROM Doctor
GROUP BY Doc_specialization;

SELECT * from Patient where P_first_name like 'a%';

SELECT Doctor.Doc_first_name as Doctor_Name, Patient.p_first_name as Patient_Name
FROM Doctor
INNER JOIN Patient
ON Doctor.Doc_id = Patient.Doc_id
order by Doctor_Name;

SELECT Medicine.medi_price as Medicine_Price, Medicine.medi_quantity as Medicine_Quantity, Patient.p_first_name as Patient_Name
FROM Patient
INNER JOIN Medicine
ON Medicine.P_id = Patient.P_id
order by Medicine_Price desc;

SELECT Room.room_type, Patient.p_first_name as Patient_Name
FROM Patient
INNER JOIN Room
ON Room.P_id = Patient.P_id;

SELECT Doctor.Doc_first_name, Patient.p_first_name
FROM Doctor
Left JOIN Patient
ON Doctor.Doc_id = Patient.Doc_id
order by Patient.p_first_name;

SELECT Room.room_type, Patient.p_first_name
FROM Patient
Left JOIN Room
ON Room.P_id = Patient.P_id
order by Patient.p_first_name;

-- Selected those patients who haven't purchased any medicines using left join 
SELECT Medicine.medi_price as Medicine_Price, Medicine.medi_quantity as Medicine_Quantity, Patient.p_first_name as Patient_Name
FROM Patient
LEFT JOIN Medicine
ON Medicine.P_id = Patient.P_id
where Medicine.P_id is null
order by Medicine_Price desc;


SELECT Doctor.Doc_first_name, Patient.p_first_name
FROM Patient
right JOIN Doctor
ON Doctor.Doc_id = Patient.Doc_id;

-- Selected those patients who have purchased medicines using right join 
SELECT Medicine.medi_price as Medicine_Price, Medicine.medi_quantity as Medicine_Quantity, Patient.p_first_name as Patient_Name
FROM Medicine
RIGHT JOIN Patient
ON Medicine.P_id = Patient.P_id
where Medicine.P_id is not null
order by Medicine_Price desc;

SELECT Room.room_type, Patient.p_first_name
FROM Room
right JOIN Patient
ON Room.P_id = Patient.P_id
where Patient.P_first_name like 'r%'
order by Patient.p_first_name;

