CREATE DATABASE NEW_2;
USE NEW_2;
CREATE TABLE employees (
    emp_id INT,
    name VARCHAR(50),
    department VARCHAR(30),
    salary INT,
    experience INT
);
INSERT INTO employees VALUES
(101, 'Amit', 'HR', 30000, 2),
(102, 'Neha', 'IT', 50000, 5),
(103, 'Rohit', 'Finance', 45000, 4),
(104, 'Simran', 'IT', 60000, 6),
(105, 'Kunal', 'HR', 32000, 3),
(106, 'Pooja', 'Marketing', 40000, 4),
(107, 'Arjun', 'IT', 70000, 8),
(108, 'Meena', 'Finance', 48000, 5),
(109, 'Vikas', 'Marketing', 35000, 2),
(110, 'Anita', 'HR', 38000, 3);

SELECT department, COUNT(*) 
FROM employees
GROUP BY department;

SELECT department, COUNT(*) 
FROM employees
GROUP BY department
HAVING COUNT(*) > 2;

CREATE TABLE NEW_2.COMPANY(
CUSTOMER VARCHAR(100),
CITY VARCHAR(100),
ORDERS INT,
REVENUE FLOAT);


INSERT INTO COMPANY VALUES
('A','NOIDA',2,2000),
('B','NOIDA',5,5000),
('C','BANGLORE',3,3000),
('D','DELHI',8,8000),
('E','BANGLORE',5,5000),
('F','DELHI',1,1000),
('G','DELHI',5,5000),
('H','BANGLORE',8,8000),
('I','JAIPUR',3,3000),
('J','JAIPUR',9,9000);

SELECT * FROM COMPANY
WHERE city = 'JAIPUR';

SELECT * FROM COMPANY 
WHERE REVENUE>5000;

SELECT CUSTOMER, SUM(REVENUE) AS total_revenue
FROM COMPANY
GROUP BY CUSTOMER;

SELECT * FROM COMPANY
WHERE ORDERS > 5; 


SELECT CUSTOMER, REVENUE
FROM COMPANY
ORDER BY REVENUE DESC
LIMIT 3;


CREATE TABLE NEW_2.ORDERS(
ORDER_ID INT,
RESTRO VARCHAR(100),
CITY VARCHAR(100),
AMOUNT INT,
ORDER_DATE date);

INSERT INTO ORDERS VALUES
(1,'Tandoori Flames','Delhi',400,'2026-03-23'),
(2,'Urban Tadka','Delhi',550,'2026-03-23'),
(3,'Tandoori Flames','Delhi',540,'2026-03-21'),
(4,'Street Spice Hub','Noida',900,'2026-03-22'),
(5,'Street Spice Hub','Noida',812,'2026-03-23'),
(6,'Urban Tadka','Delhi',1200,'2026-03-22'),
(7,'Urban Tadka','Delhi',350,'2026-03-23'),
(8,'Street Spice Hub','Noida',500,'2026-03-22'),
(9,'Tandoori Flames','Delhi',860,'2026-03-23'),
(10,'Tandoori Flames','Delhi',240,'2026-03-22');

Select * FROM ORDERS
WHERE CITY = 'DELHI';

SELECT * FROM ORDERS 
WHERE AMOUNT > 300;

SELECT RESTRO, SUM(AMOUNT) AS total_revenue
FROM ORDERS
GROUP BY RESTRO;

SELECT RESTRO, COUNT(*) 
FROM ORDERS
GROUP BY RESTRO
HAVING COUNT(*) > 3;

SELECT CITY, COUNT(*)
FROM ORDERS
GROUP BY CITY;


USE NEW_2;
CREATE TABLE SALES(
sale_id INT,
    product VARCHAR(50),
    category VARCHAR(30),
    quantity INT,
    price INT,
    sale_date DATE
);

INSERT INTO SALES VALUES
(1,'Laptop','Electronics',2,50000,'2026-03-21'),
(2,'Mobile','Electronics',5,20000,'2026-03-22'),
(3,'Shirt','Clothing',10,1500,'2026-03-23'),
(4,'Shoes','Clothing',4,3000,'2026-03-21'),
(5,'TV','Electronics',1,40000,'2026-03-22'),
(6,'Jeans','Clothing',6,2000,'2026-03-23'),
(7,'Tablet','Electronics',3,15000,'2026-03-21'),
(8,'Jacket','Clothing',2,3500,'2026-03-22'),
(9,'Fridge','Electronics',1,30000,'2026-03-23'),
(10,'T-shirt','Clothing',8,800,'2026-03-21'),
(11,'AC','Electronics',2,35000,'2026-03-22'),
(12,'Watch','Accessories',7,2500,'2026-03-23'),
(13,'Bag','Accessories',5,1200,'2026-03-21'),
(14,'Headphones','Electronics',6,3000,'2026-03-22'),
(15,'Belt','Accessories',9,700,'2026-03-23');

SELECT product, SUM(quantity) AS total_quantity
FROM sales
GROUP BY product;

SELECT CATEGORY, SUM(PRICE*QUANTITY) AS TOTAL_REVENUE
FROM SALES
GROUP BY CATEGORY;

SELECT CATEGORY, AVG(PRICE) AS AVG_PRICE
FROM SALES
GROUP BY CATEGORY;

SELECT PRODUCT, MAX(QUANTITY) AS TOTAL_QTY
FROM SALES
GROUP BY PRODUCT;

-- Categories with total sales > 100000
SELECT CATEGORY, SUM(PRICE*QUANTITY) AS TOTAL_SALES
FROM SALES
GROUP BY CATEGORY
HAVING SUM(PRICE*QUANTITY) > 100000;

-- Products with total quantity > 10
SELECT PRODUCT, SUM(QUANTITY) AS TOTAL_QTY
FROM SALES
GROUP BY PRODUCT
HAVING SUM(QUANTITY) >= 10;

-- Total sales per category only for Electronics
SELECT category, SUM(quantity * price) AS total_sales
FROM sales
WHERE category = 'Electronics'
GROUP BY category; 

