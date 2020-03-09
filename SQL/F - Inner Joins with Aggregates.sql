--Inner Joins With Aggregates Exercises
USE [A01-School]
GO

--1. How many staff are there in each position? Select the number and Position Description
SELECT  PositionDescription,                    --  <-- non-aggregate
        COUNT(S.StaffID) AS 'Number of Staff'   --  <-- aggregate
FROM    Staff AS S
    INNER JOIN Position AS P ON P.PositionID = S.PositionID
GROUP BY PositionDescription 
 
-- Out of curiosity, what are all the position names?
SELECT  PositionDescription FROM Position -- There are 7 positions...
-- but I only see 6 positions in the answer to Q1.
-- That's because I'm using an INNER JOIN, and data has to be present
-- in BOTH tables for it to be included.
-- Which position does not have staff? For that answer, you'll have to wait for the OUTER JOIN.

--2. Select the average mark for each course. Display the CourseName and the average mark. Sort the results by average in descending order.
SELECT  CourseName, AVG(Mark) AS 'Average Mark'
FROM    Registration AS R
    INNER JOIN Course AS C ON R.CourseId = C.CourseId
GROUP BY CourseName
ORDER BY 'Average Mark' DESC

-- (SQ) 3. How many payments where made for each payment type. Display the PaymentTypeDescription and the count.
 -- TODO: Student Answer Here... 
 SELECT PT.PaymentTypeDescription, COUNT(PT.PaymentTypeDescription) AS 'Count'
 FROM PaymentType PT
	INNER JOIN Payment P
	ON PT.PaymentTypeID = P.PaymentTypeID
GROUP BY PT.PaymentTypeDescription
 
--4. Select the average Mark for each student. Display the Student Name and their average mark. Use table aliases in your FROM & JOIN clause.
SELECT  S.FirstName  + ' ' + S.LastName AS 'Student Name',
        AVG(R.Mark)                     AS 'Average'
FROM    Registration AS R
        INNER JOIN Student AS S
            ON S.StudentID = R.StudentID
GROUP BY    S.FirstName  + ' ' + S.LastName  -- Since my non-aggregate is an expression,
                                             -- I am using the same expression in my GROUP BY

-- (SQ) 5. Select the same data as question 4 but only show the student names and averages that are 80% or higher. (HINT: Remember the HAVING clause?)
 -- TODO: Student Answer Here... 
 SELECT S.FirstName + ' ' + S.LastName 'Full Name', AVG(R.Mark) 'AVG Mark'
 FROM Student S
	INNER JOIN Registration R
	ON S.StudentID = R.StudentID
GROUP BY S.FirstName + ' ' + S.LastName
HAVING AVG(R.Mark) >= 80

-- (SQ) 6. What is the highest, lowest and average payment amount for each payment type Description?
 -- TODO: Student Answer Here... 
 SELECT PT.PaymentTypeDescription, MIN(P.Amount) 'Min', Max(P.Amount) 'Max'
 FROM PaymentType PT
	INNER JOIN Payment P
	ON PT.PaymentTypeID = P.PaymentTypeID
 GROUP BY PT.PaymentTypeDescription

-- (SQ) 7. Which clubs have 3 or more students in them? Display the Club Names.
 -- TODO: Student Answer Here... 
 SELECT C.ClubName, COUNT(A.StudentID) 'Number of members'
 FROM Club C
	INNER JOIN Activity A
	ON A.ClubId = C.ClubId
GROUP BY C.ClubName
HAVING COUNT(A.StudentID) >= 3