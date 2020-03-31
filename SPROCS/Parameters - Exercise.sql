--Stored Procedures (Sprocs)
--  A Stored Procedure is a controlled execution of some SQL script.

USE [A01-School]
GO

/* *******************************************
  Each Stored Procedure has to be the first statement in a batch,
    so place a GO statement in-between each question to execute 
    the previous batch (question) and start another.

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.ROUTINES WHERE ROUTINE_TYPE = N'PROCEDURE' AND ROUTINE_NAME = 'SprocName')
    DROP PROCEDURE SprocName
GO
CREATE PROCEDURE SprocName
    -- Parameters here
AS
    -- Body of procedure here
RETURN
GO
*/


IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.ROUTINES WHERE ROUTINE_TYPE = N'PROCEDURE' AND ROUTINE_NAME = 'GetName')
    DROP PROCEDURE GetName
GO
CREATE PROCEDURE GetName
    -- Parameters here
AS
    -- Body of procedure here
    SELECT  'Dan', 'Gilleland'
RETURN
GO

-- Execute (run/call) the stored procedure as follows:
EXEC GetName
GO


--1.	Create a stored procedure called “GoodCourses” to select all the course names that have averages  greater than a given value. 

--2.	Create a stored procedure called “HonorCoursesForOneTerm” to select all the course names that have average > a given value in a given semester. *can check parameters in one conditional expression and a common message printed if any of them are missing*

--3.	Create a stored procedure called “NotInACourse” that lists the full names of the staff that are not taught a given courseID.

--4.	Create a stored procedure called “LowCourses” to select the course name of the course(s) that have had less than a given number of students in them.

--5.	Create a stored procedure called “ListaProvince” to list all the students names that are in a given province.

--6.	Create a stored procedure called “transcript” to select the transcript for a given studentID. Select the StudentID, full name, course ID’s, course names, and marks.

--7.	Create a stored procedure called “PaymentTypeCount” to select the count of payments made for a given payment type description. 

--8.	Create stored procedure called “Class List” to select student Full names that are in a course for a given semesterCode and Coursename.
