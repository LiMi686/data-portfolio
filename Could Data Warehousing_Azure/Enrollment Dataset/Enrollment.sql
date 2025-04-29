#CREATE DATA
TABASE Enrollment;
#SHOW DATABASES;

USE Enrollment;
############################################# Department Table #######################################################
DROP TABLE IF EXISTS student;
DROP TABLE IF EXISTS Department;
#(a)  Create a table
	CREATE TABLE Department (
		DepartmentID TINYINT NOT NULL,
        DepartmentNm VARCHAR(40) NOT NULL,
        DepartmentAcronym CHAR(10), 
        PRIMARY KEY (DepartmentID)
);

#(B)  Show the table definition (DDL) that you implemented
SHOW CREATE TABLE Department;

#(C） Insert the complete set
INSERT INTO Department (DepartmentID, DepartmentNm, DepartmentAcronym) VALUES(101, 'Computer Science', 'CS');
INSERT INTO Department (DepartmentID, DepartmentNm, DepartmentAcronym) VALUES(102, 'Information Sciences', 'INFO');
INSERT INTO Department (DepartmentID, DepartmentNm, DepartmentAcronym) VALUES(103, 'Data Science', 'DS');
INSERT INTO Department (DepartmentID, DepartmentNm, DepartmentAcronym) VALUES(104, 'Marketing', 'MKT');
INSERT INTO Department (DepartmentID, DepartmentNm, DepartmentAcronym) VALUES(105, 'Engineering & Technology Management', 'ETM');

#(D)  Retrieve the data, order by PK columns
SELECT *
FROM Department 
ORDER BY DepartmentID;


#### ####################################Student Table ##########################################
DROP TABLE IF EXISTS Enrollment.Student;  

CREATE TABLE Enrollment.Student (
    StudentID INTEGER NOT NULL,
    DepartmentID TINYINT NOT NULL,
    StudentFirstNm VARCHAR(20), 
    StudentLastNm VARCHAR(20) NOT NULL, 
    EnrollmentDt DATE NOT NULL,
    StudentPhoneTxt VARCHAR(15),
    StudentAddress VARCHAR(50),
    StudentCityNm VARCHAR(20),
    StudentStateCd CHAR(2),
    StudentZipCd CHAR(5),
    PRIMARY KEY (StudentID),
    FOREIGN KEY (DepartmentID) REFERENCES Department(DepartmentID)
);

SHOW CREATE TABLE Enrollment.Student;

INSERT INTO Enrollment.Student 
(StudentID, DepartmentID, StudentFirstNm, StudentLastNm, EnrollmentDt, StudentPhoneTxt, StudentAddress, StudentCityNm, StudentStateCd, StudentZipCd)
VALUES 
(1, 101, 'Victor', 'Evans', '2022-01-15', '(937) 795-0198', '8471 State 41 Rte', 'West Union', 'OH', '45693');

INSERT INTO Enrollment.Student 
(StudentID, DepartmentID, StudentFirstNm, StudentLastNm, EnrollmentDt, StudentPhoneTxt, StudentAddress, StudentCityNm, StudentStateCd, StudentZipCd)
VALUES 
(2, 103, 'Julia', 'Mitchell', '2021-11-15', '(231) 652-9265', '636 E Kathy St', 'Newaygo', 'MI', '49337');

INSERT INTO Enrollment.Student 
(StudentID, DepartmentID, StudentFirstNm, StudentLastNm, EnrollmentDt, StudentPhoneTxt, StudentAddress, StudentCityNm, StudentStateCd, StudentZipCd)
VALUES 
(3, 104, 'Anna', 'Stewart', '2023-11-18', '(607) 292-6272', '1040 E Lake Rd', 'Dundee', 'NY', '14837');

INSERT INTO Enrollment.Student 
(StudentID, DepartmentID, StudentFirstNm, StudentLastNm, EnrollmentDt, StudentPhoneTxt, StudentAddress, StudentCityNm, StudentStateCd, StudentZipCd)
VALUES 
(4, 105, 'Adele', 'Andrews', '2023-03-19', '(810) 732-6788', '1468 Dyemeadow Ln', 'Flint', 'MI', '48532');

INSERT INTO Enrollment.Student 
(StudentID, DepartmentID, StudentFirstNm, StudentLastNm, EnrollmentDt, StudentPhoneTxt, StudentAddress, StudentCityNm, StudentStateCd, StudentZipCd)
VALUES 
(5, 102, 'Ryan', 'Elliott', '2022-03-23', '(828) 765-1438', '117 Brights Trce', 'Spruce Pine', 'NC', '28777');

INSERT INTO Enrollment.Student 
(StudentID, DepartmentID, StudentFirstNm, StudentLastNm, EnrollmentDt, StudentPhoneTxt, StudentAddress, StudentCityNm, StudentStateCd, StudentZipCd)
VALUES 
(6, 101, 'Leonardo', 'Baker', '2023-04-11', '(336) 376-1149', '9144 Sylvan Rd', 'Liberty', 'NC', '27298');

INSERT INTO Enrollment.Student 
(StudentID, DepartmentID, StudentFirstNm, StudentLastNm, EnrollmentDt, StudentPhoneTxt, StudentAddress, StudentCityNm, StudentStateCd, StudentZipCd)
VALUES 
(7, 102, 'Alfred', 'Turner', '2022-08-10', '(334) 288-6988', '431 Rolling Acres Rd', 'Hope Hull', 'AL', '36043');

INSERT INTO Enrollment.Student 
(StudentID, DepartmentID, StudentFirstNm, StudentLastNm, EnrollmentDt, StudentPhoneTxt, StudentAddress, StudentCityNm, StudentStateCd, StudentZipCd)
VALUES 
(8, 101, 'Luke', 'Hawkins', '2022-03-01', '(530) 525-7340', '6680 W Lake Blvd', 'Tahoma', 'CA', '96142');

INSERT INTO Enrollment.Student 
(StudentID, DepartmentID, StudentFirstNm, StudentLastNm, EnrollmentDt, StudentPhoneTxt, StudentAddress, StudentCityNm, StudentStateCd, StudentZipCd)
VALUES 
(9, 103, 'Kristian', 'Cole', '2021-08-09', '(801) 295-9358', '1381 N 200th W', 'Centerville', 'UT', '84014');

INSERT INTO Enrollment.Student 
(StudentID, DepartmentID, StudentFirstNm, StudentLastNm, EnrollmentDt, StudentPhoneTxt, StudentAddress, StudentCityNm, StudentStateCd, StudentZipCd)
VALUES 
(10, 104, 'Amanda', 'Casey', '2023-01-03', '(530) 938-1191', '220 Terrace St', 'Weed', 'CA', '96094');

SELECT *
FROM Enrollment.Student
ORDER BY StudentID;





######################################################## Course Table ###############################################
DROP TABLE IF EXISTS Enrollment.Course;
#(a)  Create a table
	CREATE TABLE Enrollment.Course (
		CourseID CHAR(10) NOT NULL, 
		CourseSectionNbr TINYINT NOT NULL,
        CourseNm VARCHAR(60) NOT NULL,
        CourseCreditCnt TINYINT NOT NULL, 
        PRIMARY KEY (CourseID, CourseSectionNbr)
);
SHOW CREATE TABLE Enrollment.Course;

INSERT INTO Enrollment.Course (CourseID, CourseSectionNbr, CourseNm, CourseCreditCnt) VALUES('STAT 461','01' ,' Applied Statistics', '3');
INSERT INTO Enrollment.Course (CourseID, CourseSectionNbr, CourseNm, CourseCreditCnt) VALUES('DS 344', '02',' Introduction to Big Data', '3');
INSERT INTO Enrollment.Course (CourseID, CourseSectionNbr, CourseNm, CourseCreditCnt) VALUES('DS 436', '02',' Data Analytics with Python Programming', '3');
INSERT INTO Enrollment.Course (CourseID, CourseSectionNbr, CourseNm, CourseCreditCnt) VALUES('CS 575', '02',' Machine Learning', '3');
INSERT INTO Enrollment.Course (CourseID, CourseSectionNbr, CourseNm, CourseCreditCnt) VALUES('CS 577', '01',' Deep Learning', '3');
INSERT INTO Enrollment.Course (CourseID, CourseSectionNbr, CourseNm, CourseCreditCnt) VALUES('INFO 579', '01',' SQL/NoSQL Databases for Data and Information Sciences', '3');
INSERT INTO Enrollment.Course (CourseID, CourseSectionNbr, CourseNm, CourseCreditCnt) VALUES('INFO 531', '01',' Data Warehousing and Analytics in the Cloud', '3');
INSERT INTO Enrollment.Course (CourseID, CourseSectionNbr, CourseNm, CourseCreditCnt) VALUES('ETM 533', '01',' Technology Transfer', '4');
INSERT INTO Enrollment.Course (CourseID, CourseSectionNbr, CourseNm, CourseCreditCnt) VALUES('MKT 300', '01',' Marketing Strategy', '4');
INSERT INTO Enrollment.Course (CourseID, CourseSectionNbr, CourseNm, CourseCreditCnt) VALUES('MKT 420 ', '01',' Research Methodology', '4');

SELECT *
FROM Enrollment.Course
ORDER BY CourseID;


############################################# Enrollment.StudentCourse Table #################################################################
DROP TABLE IF EXISTS Enrollment.StudentCourse;
	CREATE TABLE Enrollment.StudentCourse (
		StudentID INTEGER NOT NULL, 
		CourseID CHAR(10) NOT NULL,
        CourseSectionNbr TINYINT NOT NULL,
        CourseGradeTxt CHAR(1),
        PRIMARY KEY (StudentID, CourseID, CourseSectionNbr)
);
SHOW CREATE TABLE Enrollment.StudentCourse;

INSERT INTO Enrollment.StudentCourse(StudentID, CourseID, CourseSectionNbr, CourseGradeTxt) VALUES(1,'STAT 461', 1, 'A');
INSERT INTO Enrollment.StudentCourse(StudentID, CourseID, CourseSectionNbr, CourseGradeTxt) VALUES(1,'CS 575', 2, 'B');
INSERT INTO Enrollment.StudentCourse(StudentID, CourseID, CourseSectionNbr, CourseGradeTxt) VALUES(2,'DS 436', 2, 'A');
INSERT INTO Enrollment.StudentCourse(StudentID, CourseID, CourseSectionNbr, CourseGradeTxt) VALUES(2,'CS 575', 2, 'B');
INSERT INTO Enrollment.StudentCourse(StudentID, CourseID, CourseSectionNbr, CourseGradeTxt) VALUES(3,'ETM 533', 1, 'A');
INSERT INTO Enrollment.StudentCourse(StudentID, CourseID, CourseSectionNbr, CourseGradeTxt) VALUES(3,'MKT 420', 1, 'A');
INSERT INTO Enrollment.StudentCourse(StudentID, CourseID, CourseSectionNbr, CourseGradeTxt) VALUES(4,'ETM 533', 1, 'A');
INSERT INTO Enrollment.StudentCourse(StudentID, CourseID, CourseSectionNbr, CourseGradeTxt) VALUES(4,'MKT 300', 1, 'B');
INSERT INTO Enrollment.StudentCourse(StudentID, CourseID, CourseSectionNbr, CourseGradeTxt) VALUES(5,'INFO 579', 1, 'A');
INSERT INTO Enrollment.StudentCourse(StudentID, CourseID, CourseSectionNbr, CourseGradeTxt) VALUES(5,'INFO 531', 1, 'A');
INSERT INTO Enrollment.StudentCourse(StudentID, CourseID, CourseSectionNbr, CourseGradeTxt) VALUES(5,'STAT 461', 1, 'B');
INSERT INTO Enrollment.StudentCourse(StudentID, CourseID, CourseSectionNbr, CourseGradeTxt) VALUES(6,'CS 575', 2, 'B');
INSERT INTO Enrollment.StudentCourse(StudentID, CourseID, CourseSectionNbr, CourseGradeTxt) VALUES(6,'CS 577', 1, 'A');
INSERT INTO Enrollment.StudentCourse(StudentID, CourseID, CourseSectionNbr, CourseGradeTxt) VALUES(6,'CS 579', 1, 'A');
INSERT INTO Enrollment.StudentCourse(StudentID, CourseID, CourseSectionNbr, CourseGradeTxt) VALUES(7,'DS 436', 1, 'A');
INSERT INTO Enrollment.StudentCourse(StudentID, CourseID, CourseSectionNbr, CourseGradeTxt) VALUES(7,'INFO 579', 1, 'A');
INSERT INTO Enrollment.StudentCourse(StudentID, CourseID, CourseSectionNbr, CourseGradeTxt) VALUES(8,'DS 436', 2, 'A');
INSERT INTO Enrollment.StudentCourse(StudentID, CourseID, CourseSectionNbr, CourseGradeTxt) VALUES(8,'CS 575', 2, 'A');
INSERT INTO Enrollment.StudentCourse(StudentID, CourseID, CourseSectionNbr, CourseGradeTxt) VALUES(8,'CS 577', 1, 'B');
INSERT INTO Enrollment.StudentCourse(StudentID, CourseID, CourseSectionNbr, CourseGradeTxt) VALUES(9,'DS 436', 2, 'A');
INSERT INTO Enrollment.StudentCourse(StudentID, CourseID, CourseSectionNbr, CourseGradeTxt) VALUES(9,'INFO 579', 1, 'A');
INSERT INTO Enrollment.StudentCourse(StudentID, CourseID, CourseSectionNbr, CourseGradeTxt) VALUES(9,'INFO 531', 1, 'B');
INSERT INTO Enrollment.StudentCourse(StudentID, CourseID, CourseSectionNbr, CourseGradeTxt) VALUES(10,'MKT 300', 1, 'B');
INSERT INTO Enrollment.StudentCourse(StudentID, CourseID, CourseSectionNbr, CourseGradeTxt) VALUES(10,'MKT 420', 1, 'A');
INSERT INTO Enrollment.StudentCourse(StudentID, CourseID, CourseSectionNbr, CourseGradeTxt) VALUES(10,'DS 344', 2, NULL);

SELECT *
FROM Enrollment.StudentCourse
ORDER BY StudentID;


############################################# Enrollment.Faculty Table #################################################################
DROP TABLE IF EXISTS Enrollment.Faculty;
	CREATE TABLE Enrollment.Faculty (
		FacultyID SMALLINT NOT NULL,
        FacultyFirstNm VARCHAR(20),
        FacultyLastNm CHAR(20) NOT NULL, 
        FacultyPhoneTxt VARCHAR(15) NOT NULL,
        PRIMARY KEY (FacultyID)
);
SHOW CREATE TABLE Enrollment.Faculty;

INSERT INTO Enrollment.Faculty (FacultyID, FacultyFirstNm, FacultyLastNm, FacultyPhoneTxt) VALUES('0001','David', 'Gerbing',32424231284);
INSERT INTO Enrollment.Faculty (FacultyID, FacultyFirstNm, FacultyLastNm, FacultyPhoneTxt) VALUES('0002',' Shameem', 'Akhter',23478645425);
INSERT INTO Enrollment.Faculty (FacultyID, FacultyFirstNm, FacultyLastNm, FacultyPhoneTxt) VALUES('0003','Eva', 'Askarza',23478645425);
INSERT INTO Enrollment.Faculty (FacultyID, FacultyFirstNm, FacultyLastNm, FacultyPhoneTxt) VALUES('0004','Li', 'Xu',21578645425);
INSERT INTO Enrollment.Faculty (FacultyID, FacultyFirstNm, FacultyLastNm, FacultyPhoneTxt) VALUES('0005','Nayem', 'Rahman',29478759025);
INSERT INTO Enrollment.Faculty (FacultyID, FacultyFirstNm, FacultyLastNm, FacultyPhoneTxt) VALUES('0006',NULL, 'Zuick',21978742342);
INSERT INTO Enrollment.Faculty (FacultyID, FacultyFirstNm, FacultyLastNm, FacultyPhoneTxt) VALUES('0007','Mohib', 'Rahman',78974713234);
INSERT INTO Enrollment.Faculty (FacultyID, FacultyFirstNm, FacultyLastNm, FacultyPhoneTxt) VALUES('0008','Tugrul', 'Daim',10478654233);

SELECT *
FROM Enrollment.Faculty
ORDER BY FacultyID;


############################################# Enrollment.CourseFaculty Table #################################################################

DROP TABLE IF EXISTS Enrollment.CourseFaculty;
	CREATE TABLE Enrollment.CourseFaculty (
		FacultyID SMALLINT NOT NULL,
		CourseID CHAR(10) NOT NULL,
        CourseSectionNbr TINYINT NOT NULL,
        PRIMARY KEY (FacultyID, CourseID, CourseSectionNbr)
);
SHOW CREATE TABLE Enrollment.CourseFaculty;

INSERT INTO Enrollment.CourseFaculty (FacultyID, CourseID, CourseSectionNbr) VALUES('0001', 'STAT 461', 1);
INSERT INTO Enrollment.CourseFaculty (FacultyID, CourseID, CourseSectionNbr) VALUES('0002', 'DS 344', 2);
INSERT INTO Enrollment.CourseFaculty (FacultyID, CourseID, CourseSectionNbr) VALUES('0003', 'DS 344', 2);
INSERT INTO Enrollment.CourseFaculty (FacultyID, CourseID, CourseSectionNbr) VALUES('0004', 'DS 436', 2);
INSERT INTO Enrollment.CourseFaculty (FacultyID, CourseID, CourseSectionNbr) VALUES('0005', 'DS 436', 2);
INSERT INTO Enrollment.CourseFaculty (FacultyID, CourseID, CourseSectionNbr) VALUES('0006', 'CS 575', 2);
INSERT INTO Enrollment.CourseFaculty (FacultyID, CourseID, CourseSectionNbr) VALUES('0007', 'CS 575', 2);
INSERT INTO Enrollment.CourseFaculty (FacultyID, CourseID, CourseSectionNbr) VALUES('0008', 'ETM 533', 1);
INSERT INTO Enrollment.CourseFaculty (FacultyID, CourseID, CourseSectionNbr) VALUES('0004', 'CS 577', 1);
INSERT INTO Enrollment.CourseFaculty (FacultyID, CourseID, CourseSectionNbr) VALUES('0005', 'INFO 579', 1);
INSERT INTO Enrollment.CourseFaculty (FacultyID, CourseID, CourseSectionNbr) VALUES('0005', 'INFO 531', 1);
INSERT INTO Enrollment.CourseFaculty (FacultyID, CourseID, CourseSectionNbr) VALUES('0003', 'MKT 300', 1);
INSERT INTO Enrollment.CourseFaculty (FacultyID, CourseID, CourseSectionNbr) VALUES('0001', 'MKT 420', 1);


SELECT *
FROM Enrollment.CourseFaculty
ORDER BY FacultyID;



########################################################### Q8 RETRIVE Faculty #################################################
SELECT *
FROM Enrollment.Faculty
WHERE FacultyFirstNm IS NULL
ORDER BY FacultyID;

########################################################### Q9 RETRIVE  Student #################################################
SELECT *
FROM Enrollment.Student
WHERE YEAR(EnrollmentDt) = 2023
ORDER BY StudentID;

########################################################### Q10 RETRIVE  Student #################################################
SELECT *
FROM Enrollment.Student s
WHERE EnrollmentDt = (
    SELECT MAX(s2.EnrollmentDt)
    FROM Student s2
    WHERE YEAR(s2.EnrollmentDt) = YEAR(s.EnrollmentDt)
      AND MONTH(s2.EnrollmentDt) = MONTH(s.EnrollmentDt)
)
ORDER BY StudentID;



