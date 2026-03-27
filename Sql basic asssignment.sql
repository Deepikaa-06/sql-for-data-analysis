-- CREATE DATABASE RetailDB_1;
-- Use retaildb_1;


-- CREATE TABLE Customers (
--  customer_id INT AUTO_INCREMENT PRIMARY KEY,
--  name VARCHAR(100),
--  email VARCHAR(150) UNIQUE,
--  city VARCHAR(50),
--  signup_date DATE
-- );


-- CREATE TABLE Products (
--  product_id INT AUTO_INCREMENT PRIMARY KEY,
--  product_name VARCHAR(100),
--  ategory VARCHAR(50),
--  price DECIMAL(10,2)
-- );

-- CREATE TABLE Orders (
--  order_id INT AUTO_INCREMENT PRIMARY KEY,
--  customer_id INT,
--  product_id INT,
--  order_date DATE,
--  quantity INT,
--  total_amount DECIMAL(10,2),
--  payment_mode VARCHAR(50),
--  FOREIGN KEY (customer_id) REFERENCES Customers(customer_id),
--  FOREIGN KEY (product_id) REFERENCES Products(product_id)
-- );

-- Select * from products;

-- INSERT INTO orders (order_id, customer_id, product_id, order_date, quantity, total_amount, payment_mode) VALUES
-- (1,1,1,'2024-01-05',1,79999,'UPI'),
-- (2,2,2,'2024-01-10',1,74999,'Credit Card'),
-- (3,3,3,'2024-01-15',2,9998,'Debit Card'),
-- (4,4,4,'2024-01-18',1,2499,'UPI'),
-- (5,5,5,'2024-01-20',3,5997,'Cash'),
-- (6,6,6,'2024-01-22',1,2999,'UPI'),
-- (7,7,7,'2024-01-25',1,8499,'Credit Card'),
-- (8,8,8,'2024-02-01',1,59999,'Net Banking'),
-- (9,9,9,'2024-02-05',1,55999,'UPI'),
-- (10,10,10,'2024-02-07',2,2998,'Debit Card'),
-- (11,11,1,'2024-02-10',1,79999,'Credit Card'),
-- (12,12,2,'2024-02-12',1,74999,'Net Banking'),
-- (13,13,3,'2024-02-14',1,4999,'UPI'),
-- (14,14,4,'2024-02-16',2,4998,'Cash'),
-- (15,15,5,'2024-02-20',1,1999,'UPI'),
-- (16,6,6,'2024-02-25',2,5998,'Credit Card'),
-- (17,7,7,'2024-03-01',1,8499,'UPI'),
-- (18,8,8,'2024-03-05',1,59999,'Debit Card'),
-- (19,9,9,'2024-03-07',2,111998,'Credit Card'),
-- (20,10,10,'2024-03-10',1,1499,'Cash'),
-- (21,11,5,'2024-03-12',2,3998,'UPI'),
-- (22,12,3,'2024-03-15',1,4999,'Net Banking'),
-- (23,13,4,'2024-03-18',3,7497,'Credit Card'),
-- (24,14,6,'2024-03-20',1,2999,'UPI'),
-- (25,15,7,'2024-03-25',1,79999,'Debit Card'),
-- (26,2,8,'2024-03-28',1,6499,'Credit Card'),
-- (27,5,9,'2024-04-01',1,59999,'UPI'),
-- (28,9,2,'2024-04-03',1,74999,'Cash'),
-- (29,13,9,'2024-04-05',1,55999,'Net Banking'),
-- (30,14,10,'2024-04-07',2,2998,'UPI');

-- select * from orders;

-- select name
-- from customers
-- group by name;

-- select name, city
-- from customers;

-- select name
-- from customers
-- where city = "Mumbai";

-- SELECT *
-- FROM orders
-- WHERE order_date > '2024-08-01';

-- SELECT * 
-- FROM PRODUCTS
-- WHERE PRICE > 5000;

-- SELECT COUNT(*) AS total_customers
-- FROM customers;


-- SET SQL_SAFE_UPDATES = 0;

-- UPDATE customers
-- SET city = 'Hyderabad'
-- WHERE name = 'Rohit Kumar';

-- DELETE FROM orders
-- WHERE order_id = 5;

-- select * From orders;

-- SELECT product_name, price, price + (price * 0.10) AS increased_price
-- FROM products;

-- SELECT DISTINCT city
-- FROM customers;

-- SELECT *
-- FROM customers
-- ORDER BY signup_date
-- LIMIT 3;

-- SELECT *
-- FROM customers
-- ORDER BY customer_id
-- LIMIT 2, 3;

-- SELECT * 
-- FROM products
-- Where price between 2000 and 6000;

-- SELECT *
-- FROM customers
-- WHERE city IN ('Mumbai', 'Chennai');

-- select * from customers;

-- SELECT *
-- FROM customers
-- WHERE city != 'Delhi';

-- SELECT *
-- FROM orders
-- WHERE payment_mode NOT IN ('UPI');

-- SELECT AVG(total_amount) AS average_order_amount
-- FROM orders;

-- SELECT MAX(total_amount)
-- from orders;

-- SELECT MIN(total_amount)
-- FROM ORDERS;

-- SELECT SUM(total_amount) AS total_money_spent
-- FROM orders;