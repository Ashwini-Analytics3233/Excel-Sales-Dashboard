--- Table1
CREATE TABLE Customers(
	customer_id INT PRIMARY KEY,
	customer_name VARCHAR(100),
	city VARCHAR(50)
);
SELECT * FROM Customers;
--- Table 2
CREATE TABLE Categories(
		Category_id INT PRIMARY KEY,
		Category_name VARCHAR(50)
);
SELECT * FROM Categories;
--- Table 3
CREATE TABLE Products(
		Product_id INT PRIMARY KEY,
		Product_name VARCHAR(100),
		Category_id INT REFERENCES categories(category_id),
		Price NUMERIC(10,2)
);
SELECT*FROM Products;
--- Table 4
CREATE TABLE ORDERS(
		Order_id INT PRIMARY KEY,
		Customer_id INT REFERENCES customers(customer_id),
		Product_id INT REFERENCES Products(product_id),
		Order_date DATE,
		Quantity INT
);
SELECT* FROM ORDERS;
--- INSERT DATA in customers table
INSERT INTO customers(customer_id,customer_name, city)
	VALUES	(1,'Ravi','Hyderabad'),
		(2,'Priya','Warangal'),
		(3,'Arun','Vijayawada'),
		(4,'Sneha','Hyderabad'),
		(5,'Kiran','Karimnagar'),
		(6,'Divya','Nizamabad'),
		(7,'Rahul','Khammam'),
		(8,'Anjali','Guntur'),
		(9,'Suresh','Hyderabad'),
		(10,'Kavya','Secundrabab');
SELECT * FROM customers;
--- insert values category table 2
INSERT INTO categories (category_id,category_name)
 		Values(1,'Electronics'),
		 (2,'Clothing'),
		 (3,'Home & Kitchen'),
		 (4,'Books'),
		 (5,'Accessories')
SELECT * FROM Categories;	
--- insert values table 3 products
INSERT INTO products(Product_id,Product_name,category_id,Price)
		VALUES(1,'Laptop',1,45000),
		(2,'Smartphone',1,20000),
		(3,'T-Shirt',2,500),
		(4,'Jeans',2,1200),
		(5,'Mixer',3,2500),
		(6,'Cookware Set',3,1800),
		(7,'SQL Basics BOOK',4,450),
		(8,'Novel',4,300),
		(9,'Headphone',5,1500),
		(10,'Smart Watch',5,3500)
	SELECT * FROM products;
INSERT INTO orders(order_id,customer_id,product_id,order_date,quantity)
		VALUES(1,1,1,'2026-01-05',1),
		(2,2,3,'2026-01-08',2),
		(3,3,2,'2026-01-10',1),
		(4,4,5,'2026-01-12',2),
		(5,5,4,'2026-01-15',1),
		(6,6,7,'2026-01-18',1),
		(7,7,6,'2026-01-20',3),
		(8,8,9,'2026-01-22',1),
		(9,9,8,'2026-01-25',2),
		(10,10,10,'2026-01-28',1)
DROP TABLE IF EXISTS   ORDERS
SELECT * FROM Orders;

INSERT INTO orders(order_id,customer_id,product_id,order_date,quantity)
SELECT Order_id,
((order_id - 1)%10)+1
AS customer_id,
((order_id - 1)%10)+1
AS product_id,
		DATE '2026-01-01' +
	((order_id - 11)% 180) AS 
	order_date,
		((order_id - 11)%5)+1
AS quantity
FROM generate_series(11,100)
AS order_id;
SELECT COUNT (*) FROM ORDERS;
SELECT * FROM ORDERs
Order by order_id;

SELECT SUM (quantity) 
FROM orders;

SELECT AVG(quantity)
FROM Orders;
--- total orders
SELECT COUNT(*),customer_id FROM ORDERS
GROUP BY Customer_id
Order BY Customer_id DESC;

SELECT Customer_id,SUM(quantity)
FROM Orders
GROUP BY customer_id
ORDER BY SUM(quantity) DESC;

SELECT product_id,SUM (quantity)
FROM orders
GROUP BY Product_id
ORDER BY SUM (quantity) DESC;
---- total quantity
SELECT product_name , SUM(quantity)
FROM products
INNER JOIN orders
ON orders.product_id = products.product_id
GROUP BY product_name
ORDER BY SUM(quantity) DESC;
--- product wise revenue
SELECT product_name, SUM(PRICE*QUANTITY) AS revenue
FROM products
INNER JOIN orders
ON orders.product_id = products.product_id
GROUP BY product_name
ORDER BY sum(price*quantity) DESC;
---- category wise revenue
SELECT categories.category_name,sum(products.price*orders.quantity) AS revenue
FROM categories
INNER JOIN Products
ON categories.category_id=products.category_id
INNER JOIN orders
ON orders.product_id=products.product_id
GROUP BY categories.category_name
ORDER BY SUM(products.price*orders.quantity) DESC;
--- customer revenue
SELECT customers.customer_name,sum(products.price*orders.quantity) AS revenue
FROM customers
INNER JOIN orders
ON customers.customer_id=orders.customer_id
INNER JOIN products
ON orders.product_id=products.product_id
GROUP BY customers.customer_name
ORDER BY revenue DESC;
----- month wise revenue
SELECT 
	EXTRACT(MONTH FROM orders.order_date) AS month ,
sum(products.price*orders.quantity) AS  month_revenue
FROM ORDERS
INNER JOIN Products
ON PRODUCTS.PRODUCT_ID=ORDERS.ORDER_ID
GROUP BY MONTH
ORDER BY month_revenue DESC;

SELECT 
		EXTRACT(MONTH FROM orders.order_date) AS month ,
COUNT(*) AS orders
FROM  orders
GROUP BY	EXTRACT(MONTH FROM orders.order_date) 
ORDER BY MONTH
---------- customer wise revenue
SELECT
    customers.customer_name,
    categories.category_name,
    SUM(products.price * orders.quantity) AS revenue
FROM customers
INNER JOIN orders
ON customers.customer_id = orders.customer_id
INNER JOIN products
ON orders.product_id = products.product_id
INNER JOIN categories
ON products.category_id = categories.category_id
GROUP BY customers.customer_name, categories.category_name
ORDER BY revenue DESC;


SELECT customers.customer_name,count(order_id)
FROM customers
INNER JOIN orders
ON customers.customer_id=orders.Customer_id
GROUP BY customer_name
ORDER BY COUNT(order_id) DESC;

SELECT
    customers.customer_name,
    products.product_name,
    categories.category_name,
    orders.order_date,
    orders.quantity,
    products.price,
    products.price * orders.quantity AS revenue
FROM customers
INNER JOIN orders
ON customers.customer_id = orders.customer_id
INNER JOIN products
ON orders.product_id = products.product_id
INNER JOIN categories
ON products.category_id = categories.category_id
ORDER BY revenue DESC;

