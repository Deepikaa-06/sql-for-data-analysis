CREATE DATABASE RetailDB_2; 
USE RetailDB_2; 

-- Customers
CREATE TABLE Customers (
 customer_id INT AUTO_INCREMENT PRIMARY KEY,
 name VARCHAR(100),
 email VARCHAR(100),
 city VARCHAR(50),
 signup_date DATE
);

-- 2. Suppliers
CREATE TABLE Suppliers (
 supplier_id INT AUTO_INCREMENT PRIMARY KEY,
 supplier_name VARCHAR(100),
 contact_email VARCHAR(100),
 city VARCHAR(50)
);


-- 3. Products
CREATE TABLE Products (
 product_id INT AUTO_INCREMENT PRIMARY KEY,
 product_name VARCHAR(100),
 category VARCHAR(50),
 price DECIMAL(10,2),
 stock_qty INT,
 supplier_id INT,
 FOREIGN KEY (supplier_id) REFERENCES Suppliers(supplier_id)
);


-- 4. Orders
CREATE TABLE Orders (
 order_id INT AUTO_INCREMENT PRIMARY KEY,
 customer_id INT,
 order_date DATE,
 total_amount DECIMAL(10,2),
 payment_mode VARCHAR(50),
 FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
);


-- 5. Order_Items
CREATE TABLE Order_Items (
 order_item_id INT AUTO_INCREMENT PRIMARY KEY,
 order_id INT,
 product_id INT,
 quantity INT,
 price_each DECIMAL(10,2),
 FOREIGN KEY (order_id) REFERENCES Orders(order_id),
 FOREIGN KEY (product_id) REFERENCES Products(product_id)
);

-- SELECT * FROM ORDER_ITEMS;

-- Fetch all products along with their supplier name (INNER JOIN).

SELECT p.product_name , s.supplier_name 
FROM PRODUCTS p
INNER JOIN SUPPLIERS s
ON p.supplier_id = s.supplier_id;


-- Find all customers and their orders, even if they have not placed any (LEFT JOIN).

SELECT C.customer_id, C.name, O.order_id, O.order_date, O.total_amount
FROM Customers C
LEFT JOIN Orders O
ON C.customer_id = O.customer_id;

-- Get all suppliers and the products they supply, even if no products exist for a supplier (RIGHT JOIN).

SELECT S.supplier_name, P.product_name 
FROM Products P
RIGHT JOIN Suppliers S
ON P.supplier_id = S.supplier_id;


-- Show all customers and all orders (FULL OUTER JOIN simulation using UNION).

SELECT C.customer_id, C.name, O.order_id, O.order_date
FROM Customers C
LEFT JOIN Orders O
ON C.customer_id = O.customer_id

UNION

SELECT C.customer_id, C.name, O.order_id, O.order_date
FROM Customers C
RIGHT JOIN Orders O
ON C.customer_id = O.customer_id;


-- List all products priced between ₹5000 and ₹50,000 and supplied from "Mumbai".

SELECT P.product_name, P.price, S.supplier_name, S.city
FROM Products P
INNER JOIN Suppliers S
ON P.supplier_id = S.supplier_id
WHERE P.price BETWEEN 5000 AND 50000
AND S.city = 'Mumbai';


-- Find the total number of orders placed by each customer and show only those who placed more than 2 (GROUP BY + HAVING).
SELECT C.customer_id, C.name,
COUNT(O.order_id) AS total_orders
FROM Customers C
JOIN Orders O
ON C.customer_id = O.customer_id
GROUP BY C.customer_id, C.name
HAVING COUNT(O.order_id) > 2;


-- Show each supplier’s total sales value (sum of quantity × price_each).
SELECT S.supplier_id, S.supplier_name,
SUM(OI.quantity * OI.price_each) AS total_sales
FROM Suppliers S
JOIN Products P 
ON S.supplier_id = P.supplier_id
JOIN Order_Items OI 
ON P.product_id = OI.product_id
GROUP BY S.supplier_id, S.supplier_name;


-- Find the average, highest, and lowest price of products in each category.
SELECT category,
AVG(price) AS avg_price,
MAX(price) AS highest_price,
MIN(price) AS lowest_price
FROM Products
GROUP BY category;


-- Find the top 5 customers by total spending (ORDER BY SUM(total_amount) DESC LIMIT 5).
SELECT C.customer_id, C.name,
SUM(O.total_amount) AS total_spent
FROM Customers C
JOIN Orders O 
ON C.customer_id = O.customer_id
GROUP BY C.customer_id, C.name
ORDER BY total_spent DESC
LIMIT 5;


-- Show the number of unique products ordered by each customer.
SELECT C.customer_id, C.name,
COUNT(DISTINCT OI.product_id) AS unique_products
FROM Customers C
JOIN Orders O 
ON C.customer_id = O.customer_id
JOIN Order_Items OI 
ON O.order_id = OI.order_id
GROUP BY C.customer_id, C.name;



-- Find customers who placed an order with an amount greater than the average order amount (subquery).
SELECT DISTINCT C.customer_id, C.name
FROM Customers C
JOIN Orders O 
ON C.customer_id = O.customer_id
WHERE O.total_amount > (
SELECT AVG(total_amount) 
FROM Orders);


-- Find products that have never been ordered (subquery with NOT IN).
SELECT product_id, product_name
FROM Products
WHERE product_id NOT IN (
SELECT DISTINCT product_id 
FROM Order_Items );


-- List customers who ordered at least one product from the "Electronics" category.
SELECT DISTINCT C.customer_id, C.name, P.category
FROM Customers C
JOIN Orders O 
    ON C.customer_id = O.customer_id
JOIN Order_Items OI 
    ON O.order_id = OI.order_id
JOIN Products P 
    ON OI.product_id = P.product_id
WHERE P.category = 'Electronics';


-- Get suppliers who provide products that have been ordered more than 100 times in total.
SELECT S.supplier_id, S.supplier_name
FROM Suppliers S
JOIN Products P 
ON S.supplier_id = P.supplier_id
JOIN Order_Items OI 
ON P.product_id = OI.product_id
GROUP BY S.supplier_id, S.supplier_name
HAVING SUM(OI.quantity) > 100;

-- SELECT * FROM customers;

-- Find the most expensive product(s) using a subquery with MAX().
SELECT product_name, category , price
FROM products 
WHERE price = (
SELECT MAX(price)
FROM products);


-- Show orders placed by customers who live in either Mumbai, Delhi, or Bengaluru (IN operator)
SELECT C.name, C.city, O.order_date, O.total_amount
FROM customers C
JOIN Orders O
ON C.customer_id = O.customer_id
WHERE C.city in ('Mumbai', 'Delhi', 'Bengaluru');


-- Show orders where payment mode is NOT UPI or Credit Card (NOT IN).
SELECT * 
FROM orders
WHERE payment_mode NOT IN ('UPI', 'Credit card');


-- Find customers who have no email address recorded (IS NULL).
SELECT * 
FROM customers
WHERE email IS NULL;

-- SELECT * FROM customers;


-- Show suppliers who are not from the same city as any customer (NOT IN subquery).
SELECT supplier_id, supplier_name, city
FROM Suppliers
WHERE city NOT IN (
SELECT DISTINCT city 
FROM Customers
WHERE city IS NOT NULL
);


-- Get the latest 3 orders placed, skipping the first 2 (ORDER BY + LIMIT + OFFSET).
SELECT * 
FROM orders
ORDER BY order_date DESC
LIMIT 3 OFFSET 2 ;





