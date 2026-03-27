-- CREATE DATABASE new_3;
USE new_3;

CREATE TABLE ADVSQL (
    ID INT PRIMARY KEY,
    NAME VARCHAR(50),
    SECTION VARCHAR(50),
    MARKS INT
);

INSERT INTO ADVSQL VALUES
(1, 'Amit', 'A',80),
(2, 'Neha', 'A',90),
(3, 'Raj','B', 70),
(4, 'Priya', 'B',85);

SELECT name, section , marks,
SUM(marks) OVER (partition by section) as total_marks
FROM advsql;

SELECT name, section , marks,
ROW_NUMBER() OVER (partition by section order by marks desc) as ranks
FROM advsql;

SELECT section, SUM(marks) AS total_marks
FROM advsql
GROUP BY section;

SELECT *,
AVG(marks) OVER (partition by section) as avg_marks
FROM advsql;

SELECT name, section, marks,
ROW_NUMBER() OVER (partition by section order by marks DESC) as ranks
FROM advsql;

INSERT INTO advsql VALUES
-- (5, 'Kuku', 'A',96),
(6, 'Naman', 'A',96);

-- SELECT * FROM advsql;


-- The rank() method will consider 1 as two, if both students marks are same thats why we use DENSE RANK() method.

SELECT * ,
RANK() OVER (order by marks desc) as ranks
FROM advsql;

SELECT name, section, marks,
dense_rank() OVER ( order by marks desc) as ranks
FROM advsql;

SELECT name, marks,
       LAG(marks) OVER (ORDER BY marks) AS prev_marks
FROM Advsql;



SELECT name, marks,
       LEAD(marks) OVER (ORDER BY marks) AS next_marks
FROM advsql;

