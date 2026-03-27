-- how can we create database?
-- create database name_database
CREATE DATABASE sc10;
-- to sell all database (show database)
-- to delete database ( drop database name_Database)

CREATE DATABASE IF NOT EXISTS SC10;
USE SC10;

CREATE TABLE IF NOT EXISTS STUDENTS(
ROLL_NO INT,
NAME VARCHAR(100),
AGE INT,
GRADE CHAR(1),
MARKS INT
);


CREATE DATABASE NEW_1;
USE NEW_1;
CREATE TABLE marks(
STU_ID INT,
NAME VARCHAR(100),
AGE INT,
GRADE CHAR(10),
MARKS FLOAT);

USE NEW_1;
desc marks;

insert into MARKS(STU_ID,name,age,grade,marks) values(1,'ankit',23,'A',87),
(2,'ashish',22,'B',76),
(3,'piyush',20,'C',66),
(4,'deepika',22,'D',56),
(5,'rizwan',22,'F',44);

SELECT * FROM MARKS;
SELECT * FROM MARKS WHERE MARKS>60;

USE new_1;
CREATE TABLE EMPLOYEE(
EMP_ID INT,
NAME VARCHAR(100),
DEPARTMENT VARCHAR(100),
SALARY INT,
CITY VARCHAR(100));

INSERT INTO EMPLOYEE(EMP_ID, NAME, DEPARTMENT, SALARY, CITY) VALUES
(1, 'Aman', 'HR', 30000, 'Delhi'),
(2, 'Riya', 'IT', 45000, 'Mumbai'),
(3, 'Kabir', 'Finance', 40000, 'Pune'),
(4, 'Sneha', 'Marketing', 35000, 'Jaipur'),
(5, 'Arjun', 'IT', 48000, 'Bangalore'); 

USE new_1;
CREATE TABLE PRODUCT(
PRO_ID INT,
NAME VARCHAR(100),
CATEGORY VARCHAR(100));

INSERT INTO PRODUCT(PRO_ID,NAME,CATEGORY) VALUES
(1, 'Laptop', 'Electronics'),
(2, 'Mobile', 'Electronics'),
(3, 'Shoes', 'Fashion'),
(4, 'Watch', 'Accessories'),
(5, 'Backpack', 'Bags');

SELECT * FROM PRODUCT;


USE NEW_1;
CREATE TABLE TEACHERS(
TEACHER_ID INT,
NAME VARCHAR(100),
SUBJECT VARCHAR(100),
SALARY INT
);

INSERT INTO TEACHERS(TEACHER_ID, NAME, SUBJECT, SALARY) VALUES
(1, 'Anita', 'Maths', 40000),
(2, 'Rohit', 'Science', 42000),
(3, 'Meena', 'English', 39000);

CREATE DATABASE NEW_2;

USE NEW_2;
CREATE TABLE MOVIES(
MOVIE_ID INT,
MOVIE_NAME VARCHAR(100),
GENRE VARCHAR(50),
RATING FLOAT
);

INSERT INTO MOVIES(MOVIE_ID, MOVIE_NAME, GENRE, RATING) VALUES
(1, 'Inception', 'Sci-Fi', 8.8),
(2, '3 Idiots', 'Comedy', 8.4),
(3, 'Titanic', 'Romance', 7.9);

SELECT * FROM MOVIES;

CREATE  DATABASE NEW_3;
USE NEW_3;
CREATE TABLE FOOD(
NAME VARCHAR(100),
PRICE INT,
RATING FLOAT
);

INSERT INTO FOOD(NAME,  PRICE, RATING) VALUES
('Burger', 100, 4),
('Pizza',250,4.5),
('Noodles',150,3);



CREATE DATABASE NEW_4;
DROP DATABASE NEW_4;

CREATE TABLE SC10.SKILL(
ROLL_NO INT,
NAME VARCHAR(100),
AGE INT,
GRADE CHAR(1),
MARKS INT
);

USE SC10;
insert into SKILL(ROLL_NO,name,age,grade,marks) values(1,'ankit',23,'A',87),
(2,'ashish',22,'B',76),
(3,'piyush',20,'C',66),
(4,'deepika',22,'D',56),
(5,'rizwan',22,'F',44);


SELECT * FROM SKILL WHERE GRADE = 'C';

DROP DATABASE NEW_3;
DROP DATABASE NEW_2;