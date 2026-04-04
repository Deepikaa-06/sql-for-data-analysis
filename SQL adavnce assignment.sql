CREATE DATABASE retaildb_3;

USE retaildb_3;

-- 1. Customers
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


-- 3. Shippers
CREATE TABLE Shippers (
 shipper_id INT AUTO_INCREMENT PRIMARY KEY,
 shipper_name VARCHAR(100),
 contact VARCHAR(100)
);


-- 4. Payment Methods
CREATE TABLE Payment_Methods (
 payment_id INT AUTO_INCREMENT PRIMARY KEY,
 payment_type VARCHAR(50) UNIQUE
);


-- 5. Products
CREATE TABLE Products (
 product_id INT AUTO_INCREMENT PRIMARY KEY,
 product_name VARCHAR(100),
 category VARCHAR(50),
 price DECIMAL(10,2),
 stock_qty INT,
 supplier_id INT,
 FOREIGN KEY (supplier_id) REFERENCES Suppliers(supplier_id));
 
 
 -- 6. Orders (normalized, no total_amount column)
CREATE TABLE Orders (
 order_id INT AUTO_INCREMENT PRIMARY KEY,
 customer_id INT,
 order_date DATE,
 payment_id INT,
 shipper_id INT,
 FOREIGN KEY (customer_id) REFERENCES Customers(customer_id),
 FOREIGN KEY (payment_id) REFERENCES Payment_Methods(payment_id),
 FOREIGN KEY (shipper_id) REFERENCES Shippers(shipper_id)
);


-- 7. Order_Items
CREATE TABLE Order_Items (
 order_item_id INT AUTO_INCREMENT PRIMARY KEY,
 order_id INT,
 product_id INT,
 quantity INT,
 price_each DECIMAL(10,2),
 FOREIGN KEY (order_id) REFERENCES Orders(order_id),
 FOREIGN KEY (product_id) REFERENCES Products(product_id)
);

 -- Question 1
 -- Find the total revenue collected by each shipper.
 
SELECT s.shipper_name,
   SUM(oi.quantity * oi.price_each) AS total_revenue
FROM Order_Items oi
JOIN Orders o 
    ON oi.order_id = o.order_id
JOIN Shippers s 
    ON o.shipper_id = s.shipper_id
GROUP BY s.shipper_name;
 
 
 -- Question 2
 -- Show the top 5 highest-spending customers along with their total payments.
 
 
SELECT C.name, C.customer_id,
       SUM(oi.quantity * oi.price_each) AS total_spent
FROM Customers C
JOIN Orders O
  ON C.customer_id = O.customer_id
JOIN Order_Items oi
  ON O.order_id = oi.order_id
GROUP BY C.customer_id, C.name
ORDER BY total_spent DESC
LIMIT 5;
 
 
 -- Question 3
 -- Find product categories where the average selling price is greater than 8000.
 
SELECT category, 
AVG(price) as avg_price
FROM products
group by category
 HAVING AVG(price) > 8000;
 

-- Question 4
-- Show the total number of orders placed per city, sorted by highest to lowest.

SELECT C.city, COUNT(O.order_id) as total_orders
 FROM customers C
 JOIN orders O
 ON C.customer_id = O.customer_id
 GROUP BY C.city
 ORDER BY COUNT(O.order_id) DESC;
 
 
 -- Question 5
 -- Find suppliers who supply more than 1 product category.
 
SELECT s.supplier_name,
    COUNT(DISTINCT p.category) AS category_count
FROM Suppliers s
JOIN Products p 
ON s.supplier_id = p.supplier_id
GROUP BY s.supplier_name
HAVING COUNT(DISTINCT p.category) > 1;


-- Question 6
-- Show each order along with the number of items it contains.


SELECT o.order_id,
    COUNT(oi.order_item_id) AS total_items
FROM Orders o
LEFT JOIN Order_Items oi 
ON o.order_id = oi.order_id
GROUP BY o.order_id;


-- Question 7
-- Find customers who have spent more than the average spending of all customers.

SELECT name, city, total_spent
FROM (
    SELECT c.name, c.city,
           SUM(oi.quantity * oi.price_each) AS total_spent,
           AVG(SUM(oi.quantity * oi.price_each)) OVER () AS avg_spent
    FROM customers c
    JOIN orders o ON o.customer_id = c.customer_id
    JOIN order_items oi ON o.order_id = oi.order_id
    GROUP BY c.customer_id, c.name, c.city
) t
WHERE total_spent > avg_spent;
 
 
 
 -- Question 8
 -- List all products whose price is higher than the average product price in their category.
 
SELECT p.product_name, p.category, p.price
FROM Products p
WHERE p.price > (
    SELECT AVG(p2.price)
    FROM Products p2
    WHERE p.category = p2.category
);


-- Question 9
-- Show customers who placed at least one order with total_amount greater than 50,000.


SELECT c.name, P.price
FROM Customers c
JOIN Orders o 
ON c.customer_id = o.customer_id
JOIN Order_Items oi 
ON o.order_id = oi.order_id
JOIN  Products P
ON oi.product_id =  P.product_id
GROUP BY c.customer_id, c.name, P.price, o.order_id
HAVING SUM(oi.quantity * oi.price_each) > 50000;


-- Question 10
-- Find customers who placed more orders than the average number of orders per customer.


SELECT c.name, COUNT(o.customer_id) AS total_order
FROM customers c 
JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.name
HAVING total_order > (
    SELECT AVG(order_count)
    FROM (
        SELECT COUNT(*) AS order_count
        FROM orders
        GROUP BY customer_id
    ) t
);


 -- Question 11
 -- Find the most expensive product(s) in the catalog.
 
SELECT product_name, price 
 FROM products
 ORDER BY price DESC
 LIMIT 1; 
 
 
 -- Question 12
 -- Rank customers based on their total spending.
 
SELECT c.name,
 SUM(oi.quantity * oi.price_each) AS total_spent,
 RANK() OVER (ORDER BY SUM(oi.quantity * oi.price_each) DESC) AS rank_order
 FROM customers c
 JOIN orders o ON c.customer_id = o.customer_id
 JOIN order_items oi ON o.order_id = oi.order_id
 GROUP BY c.customer_id, c.name;
 
 
 
 -- Question 13
 -- Find cumulative sales amount by order date.

SELECT order_date,
       SUM(daily_sales) OVER (ORDER BY order_date) AS cumulative_sales
FROM (
    SELECT o.order_date,
           SUM(oi.quantity * oi.price_each) AS daily_sales
    FROM orders o
    JOIN order_items oi ON o.order_id = oi.order_id
    GROUP BY o.order_date
) t;



-- Question 14
-- Get each customer’s order count and show their percentage contribution.


SELECT c.name,
COUNT(o.order_id) AS order_count,
ROUND(
	COUNT(o.order_id) * 100.0 /
	SUM(COUNT(o.order_id)) OVER (), 2
       ) AS percentage
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.name;


-- Question 15
-- Show the most recent order per customer.


SELECT *
FROM (
    SELECT c.name, o.order_id, o.order_date,
           ROW_NUMBER() OVER (
               PARTITION BY c.customer_id
               ORDER BY o.order_date DESC
           ) AS rn
    FROM customers c
    JOIN orders o ON c.customer_id = o.customer_id
) t
WHERE rn = 1;


-- Question 16
-- List each product with its sales quantity and rank products within each category by total sales.


SELECT category, product_name, total_qty,
       DENSE_RANK() OVER (
           PARTITION BY category
           ORDER BY total_qty DESC
       ) AS rank_in_category
FROM (
    SELECT p.category, p.product_name,
           SUM(oi.quantity) AS total_qty
    FROM products p
    JOIN order_items oi ON p.product_id = oi.product_id
    GROUP BY p.product_id, p.category, p.product_name
) t;


-- SELECT * FROM PRODUCTS;

-- Question 17
-- Categorize products as ‘High’, ‘Medium’, or ‘Low’ price using CASE.

SELECT product_name,price,category,
   CASE
   WHEN price > 50000 THEN 'High'
   WHEN price BETWEEN 30000 and 49000 THEN 'Medium'
   ELSE 'Low'
END AS price_category   
FROM products;


-- Question 18
-- Use a CTE to find top 3 customers by spending.


WITH customer_spending AS (
    SELECT c.customer_id, c.name,
           SUM(oi.quantity * oi.price_each) AS total_spent
    FROM customers c
    JOIN orders o ON c.customer_id = o.customer_id
    JOIN order_items oi ON o.order_id = oi.order_id
    GROUP BY c.customer_id, c.name
)
SELECT *
FROM customer_spending
ORDER BY total_spent DESC
LIMIT 3;


-- Question 19
-- Use a CTE with CASE to classify customers by loyalty (based on number of orders).


WITH customer_orders AS (
    SELECT c.customer_id, c.name,
           COUNT(o.order_id) AS order_count
    FROM customers c
    LEFT JOIN orders o ON c.customer_id = o.customer_id
    GROUP BY c.customer_id, c.name
)
SELECT name, order_count,
       CASE
           WHEN order_count >= 5 THEN 'High Loyalty'
           WHEN order_count BETWEEN  2 AND 4 THEN 'Medium Loyalty'
           ELSE 'Low Loyalty'
       END AS loyalty_status
FROM customer_orders;



-- Question 20
-- Find monthly revenue growth percentage compared to the previous month.


WITH monthly_sales AS (
    SELECT DATE_FORMAT(o.order_date, '%Y-%m') AS month,
           SUM(oi.quantity * oi.price_each) AS revenue
    FROM orders o
    JOIN order_items oi ON o.order_id = oi.order_id
    GROUP BY DATE_FORMAT(o.order_date, '%Y-%m')
)
SELECT month, revenue,
       ROUND(
           (revenue - LAG(revenue) OVER (ORDER BY month)) * 100.0 /
           LAG(revenue) OVER (ORDER BY month), 2
       ) AS growth_percent
FROM monthly_sales;


-- Question 21 
-- Find top 2 customers per city based on total spending.


WITH CustomerSpending AS (
    SELECT c.city,c.customer_id,c.name,
        SUM(oi.quantity * oi.price_each) AS total_spent
    FROM Customers c
    JOIN Orders o ON c.customer_id = o.customer_id
    JOIN Order_Items oi ON o.order_id = oi.order_id
    GROUP BY c.city, c.customer_id, c.name
),
RankedCustomers AS (
    SELECT *,
           RANK() OVER (PARTITION BY city ORDER BY total_spent DESC) AS rnk
    FROM CustomerSpending
)
SELECT *
FROM RankedCustomers
WHERE rnk <= 2;


-- Question 22
-- Find top 3 cities with highest sales revenue including shipper name.

SELECT c.city, s.shipper_name,
    SUM(oi.quantity * oi.price_each) AS total_revenue
FROM Orders o
JOIN Customers c ON o.customer_id = c.customer_id
JOIN Shippers s ON o.shipper_id = s.shipper_id
JOIN Order_Items oi ON o.order_id = oi.order_id
GROUP BY c.city, s.shipper_name
ORDER BY total_revenue DESC
LIMIT 3;



-- Question 23
-- List all orders with customer name, product name, supplier, and shipper.


SELECT o.order_id, c.name AS customer_name,
p.product_name, s.supplier_name, sh.shipper_name
FROM Orders o
JOIN Customers c ON o.customer_id = c.customer_id
JOIN Order_Items oi ON o.order_id = oi.order_id
JOIN Products p ON oi.product_id = p.product_id
JOIN Suppliers s ON p.supplier_id = s.supplier_id
JOIN Shippers sh ON o.shipper_id = sh.shipper_id;




-- Question 24
-- Show total sales per supplier along with average order value.

SELECT s.supplier_name,
    SUM(oi.quantity * oi.price_each) AS total_sales,
    AVG(oi.quantity * oi.price_each) AS avg_order_value
FROM Suppliers s
JOIN Products p ON s.supplier_id = p.supplier_id
JOIN Order_Items oi ON p.product_id = oi.product_id
GROUP BY s.supplier_name;


-- Question 25
-- Show product categories that contributed more than 30% of total sales revenue.


WITH CategorySales AS (
    SELECT p.category,
        SUM(oi.quantity * oi.price_each) AS category_revenue
    FROM Products p
    JOIN Order_Items oi ON p.product_id = oi.product_id
    GROUP BY p.category
),
TotalSales AS (
    SELECT SUM(category_revenue) AS total_revenue
    FROM CategorySales
)
SELECT cs.category, cs.category_revenue,
    ROUND((cs.category_revenue / ts.total_revenue) * 100, 2) AS percentage
FROM CategorySales cs
CROSS JOIN TotalSales ts
WHERE (cs.category_revenue / ts.total_revenue) > 0.30;