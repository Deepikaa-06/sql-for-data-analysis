CREATE DATABASE if not exists SchoolDB;

USE SchoolDB;

CREATE TABLE if not exists Students (
    id INT PRIMARY KEY,
    name VARCHAR(50),
    location VARCHAR(50),
    marks INT,
    grade CHAR(1)
);

INSERT INTO Students VALUES
(1, 'Amit', 'Delhi', 78, 'C'),
(2, 'Riya', 'Mumbai', 88, 'B'),
(3, 'John', 'Chennai', 92, 'A'),
(4, 'Sara', 'Delhi', 67, 'D'),
(5, 'Karan', 'Pune', 74, 'C'),
(6, 'Neha', 'Delhi', 81, 'B'),
(7, 'Arjun', 'Kolkata', 59, 'D'),
(8, 'Priya', 'Mumbai', 95, 'A'),
(9, 'Rahul', 'Delhi', 70, 'C'),
(10, 'Anjali', 'Pune', 85, 'B');



-- update


select * from students;



UPDATE Students
SET marks = 95, grade = 'A'
WHERE id = 5;

-- false safe updates
SET SQL_SAFE_UPDATES = 0;


UPDATE Students
SET  grade = 'B'
WHERE marks between 70 and 80;

-- rename tables

RENAME TABLE Students TO Student_Details;

-- rename columns
-- old way 

ALTER TABLE Student_Details
CHANGE marks total_marks INT;

desc Student_Details;

-- best way 
ALTER TABLE Student_Details
RENAME COLUMN grade TO final_grade;

select * from Student_Details;


ALTER TABLE Student_Details ADD Topic varchar(200);


desc  Student_Details ;

-- subqueries

SELECT name, total_marks
FROM Student_Details
WHERE total_marks > (
    SELECT AVG(total_marks)
    FROM Student_Details
);

SELECT name,location,total_marks
FROM Student_Details
WHERE location IN (
    SELECT location
    FROM Student_Details
    WHERE total_marks > 90);
    
select * from Student_Details;

SELECT MAX(total_marks)
FROM Student_Details
WHERE total_marks < (
    SELECT MAX(total_marks)
    FROM Student_Details
);




SELECT name,location,total_marks
FROM Student_Details
WHERE total_marks IN (
    SELECT total_marks
    FROM Student_Details
    WHERE total_marks > 90
);


