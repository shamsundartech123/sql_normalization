/*-----------------------------------------------------------
1. Normalize a table with repeating groups into 2NF
-----------------------------------------------------------*/

/* ✅ 1NF: Remove repeating groups */
CREATE TABLE orders_1nf (
    order_id INT,
    customer_name VARCHAR(50),
    product_name VARCHAR(50),
    price DECIMAL(10,2)
);

/* Sample Insert */
INSERT INTO orders_1nf VALUES
(1, 'Ram', 'Keyboard', 800),
(1, 'Ram', 'Mouse', 400),
(2, 'Sita', 'Laptop', 45000);

/* ✅ 2NF: Split into separate tables to remove partial dependencies */

CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_name VARCHAR(50)
);

CREATE TABLE order_items (
    item_id INT PRIMARY KEY,
    order_id INT,
    product_name VARCHAR(50),
    price DECIMAL(10,2),
    FOREIGN KEY(order_id) REFERENCES orders(order_id)
);

/*-----------------------------------------------------------
2. Example of 3NF
-----------------------------------------------------------*/


CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(50),
    customer_city VARCHAR(50)   -- properly separated → 3NF
);

CREATE TABLE orders_3nf (
    order_id INT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    FOREIGN KEY(customer_id) REFERENCES customers(customer_id)
);

/* Sample Insert */
INSERT INTO customers VALUES
(1, 'Ram', 'Delhi'),
(2, 'Sita', 'Mumbai');

INSERT INTO orders_3nf VALUES
(101, 1, '2024-01-15'),
(102, 2, '2024-01-16');

/*-----------------------------------------------------------
3. Find AVG() order price
-----------------------------------------------------------*/

SELECT AVG(price) AS avg_order_price
FROM order_items;

/*-----------------------------------------------------------
4. Group orders by product_name and show total sales
-----------------------------------------------------------*/

SELECT product_name,
       SUM(price) AS total_sales
FROM order_items
GROUP BY product_name;

/*-----------------------------------------------------------
5. Sort the grouped data by total_sales DESC
-----------------------------------------------------------*/

SELECT product_name,
       SUM(price) AS total_sales
FROM order_items
GROUP BY product_name
ORDER BY total_sales DESC;
