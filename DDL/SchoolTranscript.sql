/***
* File: SchoolTranscript.sql
* Author: Sang Quach
* 
* CREATE DATABASE SchoolTranscript
*/
USE SchoolTranscript
GO
/* === Drop Statements === */

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'Students')
    DROP TABLE Students
IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'Courses')
    DROP TABLE Courses
IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'StudentCourses')
    DROP TABLE StudentCourses
/* === Create Tanles ===*/


CREATE TABLE Students
(
    StudentID       int
    CONSTRAINT PK_Students_StudentIS
    PRIMARY KEY                     NOT NULL,
    GivenName       varchar(50)     NOT NULL,
    SurName         varchar(50)
	CONSTRAINT CK_Students_Surname
/*
	% is a wildcard for zero or more characters (letter, digit, or other character)
	_ is a wildcard for a single character (letter, didit, or other character)
	[] are used to represent a range or set of characters that are allowed
*/
	CHECK (Surname LIKE'_%')     NOT NULL, -- LIKE allows us to do a "pattern-match" of values
--	CHECK (Surname LIKE'[a-z][a-z]%')
--						 \1/  \1/
--	Positive match for 'Fred'
--	Positive match for 'Wu'
--	Negative match for 'F'
--	Negative match for '2udor'
    DateOfBirth     datetime
	CONSTRAINT CK_Students_DateOfBirth
	CHECK (DateOfBirth < GETDATE())        NOT NULL,
    Enrolled        bit             
    CONSTRAINT DF_Students_Enrolled
    DEFAULT (1)                     NOT NULL,
)

CREATE TABLE Courses
(
    Number          varchar(10)
    CONSTRAINT PK_Courses_Number
    PRIMARY KEY                     NOT NULL,
    [Name]          varchar(50)     NOT NULL,
    Credits         decimal(3,1)
	CONSTRAINT CK_Courses_Credits
	CHECK (Credits > 0 AND Credits <= 6)    NOT NULL,
    [Hours]         tinyint
	CONSTRAINT CK_Courses_Hours
	CHECK ([Hours] BETWEEN 15 AND 180)      NOT NULL, --BETWEEN operator is inclusive
    Active          bit
        CONSTRAINT DF_Courses_Active
        DEFAULT (1)             NOT NULL,
    Cost            money
	CONSTRAINT CK_Courses_Cost           NOT NULL,
)

CREATE TABLE StudentCourses
(
    StudentID       int
    CONSTRAINT FK_StudentCourses_StudentID_Students_StudentID
    FOREIGN KEY REFERENCES Students(StudentID)   NOT NULL,
    CourseNumber    varchar(10)
    CONSTRAINT FK_StudentCourses_CourseNumber_Courses_Number
    FOREIGN KEY REFERENCES Courses(Number)     NOT NULL,
    [Year]          tinyint         NULL,
    Term            char(3)         NOT NULL,
    FinalMark       tinyint         NOT NULL,
    [Status]        char(1)
	CONSTRAINT CK_StudentCourses_Status
	CHECK ([Status] = 'E' OR
		   [Status] = 'C' OR
		   [Status] = 'W')         NOT NULL,
--	CHECK ([Status] IN ('E', 'C', 'W')) 
    -- Table level constraint for composite keys
    CONSTRAINT PK_StudentCourses_StudentID_CourseNumber
    PRIMARY KEY (StudentID, CourseNumber),

-- Table-level constraint involving more than one column
	CONSTRAINT CK_StudentCourses_FinalMark_Status
	CHECK (([Status] = 'C' AND FinalMark IS NOT NULL) OR
			([Status] IN ('E', 'W') AND FinalMark IS NULL))
)

/*-----------Indexes-----------*/
-- For all foreign keys
CREATE NONCLUSTERED INDEX IX_StudentCourses_StudentID
	ON StudentCourses (StudentID)
CREATE NONCLUSTERED INDEX IX_StudentCourses_CourseNumer
	ON StudentCourses (CourseNumber)

-- For other columns where seatching / sorting might be important
CREATE NONCLUSTERED INDEX IX_Students_Surname
	ON Students (Surname)

/*---------ALTER TABLE statements-------*/
-- 1) Add a PostalCode for the Students table
ALTER TABLE Students
	ADD PostalCode char(6) NULL
	-- Adding this as a nullable column, because students already exist,
	-- and we dont have postal codes for those students.
GO  -- I have to break the above code as a separate batch from the following

-- 2) Make sure the PostalCode follows the correct pattern A#A#A#
ALTER TABLE Students
	ADD CONSTRAINT CK_Students_PostalCode
		CHECK (PostalCode LIKE '[A-Z][0-9][A-Z][0-9][A-Z][0-9]')
		-- Match for              T    4    R    1    H    2
GO