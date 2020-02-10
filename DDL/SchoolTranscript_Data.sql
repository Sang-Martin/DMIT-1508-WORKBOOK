/*
	- SchoolTranscript_Data.sql
	- Dan Gilleland
*/

USE SchoolTranscript
GO

INSERT INTO Students(GivenName, SurName, DateOfBirth)  -- notice no Enrolled column
VALUES ('Patsy', 'Gashington', '19810310 10:34:09 PM'),
		('Kim ', 'Russell', '19920605 10:34:10 PM'),
		('Gaxine ', 'Cooper', '19780303 10:34:11 PM'),
		('Rene ', 'Ferguson', '19610709 10:34:12 PM'),
		('Celina ', 'Austin', '19660703 10:34:13 PM'),
		('Jo', 'Cox', '19660704 10:34:14 PM'),
		('Larry ', 'Lawrence', '19760506 10:34:15 PM')

DROP TABLE Students;

SELECT * FROM Students

INSERT INTO Courses(Number, [Name], Credits, [Hours], Cost)
VALUES ('123', 'Bio', '6.0', '180', '1000'),
		('234', 'Phy', '5.0', '150', '800'),
		('345', 'Math', '4.0', '130', '500'),
		('456', 'Chemistry', '3.0', '110', '400'),
		('567', 'Computer', '3.0', '110', '400')

SELECT * FROM Courses	-- get all information

SELECT	Number, [Name], Credits, [Hours] -- just get specific information
FROM	Courses
WHERE	[Name] LIKE	'%Fundamentals%'

-- Write a query to get the first/last names of all students
-- whose last name starts with a 'G'

SELECT GivenName, SurName
FROM Students
WHERE	GivenName LIKE 'G%' OR SurName LIKE 'G%'
