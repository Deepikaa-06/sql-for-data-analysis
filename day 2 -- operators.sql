USE SC10;
CREATE TABLE marigold(
id INT,
name VARCHAR(50),
age INT,
class VARCHAR(10),
marks INT
);

INSERT INTO marigold VALUES
(1, 'Aman', 14, '8A', 85),
(2, 'Riya', 13, '8B', 78),
(3, 'Karan', 14, '8A', 92),
(4, 'Sneha', 13, '8C', 74),
(5, 'Rahul', 14, '8B', 88),
(6, 'Priya', 13, '8A', 81),
(7, 'Arjun', 14, '8C', 69),
(8, 'Neha', 13, '8B', 90),
(9, 'Vikas', 14, '8A', 76),
(10, 'Anjali', 13, '8C', 84);

select * from marigold where  age > 13;
select * from marigold where  marks > 80;
select * from marigold where age = 13 and marks > 80;
select * from marigold where age = 14 or marks < 95;
select * from marigold where marks between 60 and 80;
select * from marigold where class in ('8B','8C');
SELECT * FROM marigold WHERE name LIKE 'A%';  
-- a% will give names which starts with a
SELECT * FROM marigold WHERE name LIKE '%A';  
-- a% will give names which ends with a
SELECT * FROM marigold WHERE name LIKE '%a%';
-- %a% will give names which consist a 
SELECT * FROM marigold order by marks desc; 
-- order by marks desc will give marks in descending order
SELECT * FROM marigold order by name asc;
-- order by names asc will give marks in ascending order
