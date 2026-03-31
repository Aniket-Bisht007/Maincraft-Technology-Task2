CREATE TABLE customers (
    customer_id SERIAL PRIMARY KEY,
    customer_name VARCHAR(100),
    email VARCHAR(100),
    city VARCHAR(50),
    signup_date DATE
);


CREATE TABLE orders (
    order_id SERIAL PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    amount NUMERIC(10,2),
    status VARCHAR(20),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);



INSERT INTO customers (customer_name, email, city, signup_date) VALUES
('Amit Sharma', 'amit@gmail.com', 'Delhi', '2023-01-10'),
('Priya Singh', 'priya@gmail.com', 'Mumbai', '2023-02-15'),
('Rahul Verma', 'rahul@gmail.com', 'Bangalore', '2023-03-20'),
('Neha Kapoor', 'neha@gmail.com', 'Delhi', '2023-04-01');

INSERT INTO orders (customer_id, order_date, amount, status) VALUES
(1, '2023-04-01', 5000, 'Completed'),
(1, '2023-04-05', 3000, 'Completed'),
(2, '2023-04-03', 7000, 'Pending'),
(3, '2023-04-06', 2000, 'Completed');


SELECT 
    c.customer_name,
    o.order_id,
    o.amount,
    o.status
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id;


SELECT SUM(amount) AS total_revenue
FROM orders
WHERE status = 'Completed';

SELECT 
    c.customer_name,
    SUM(o.amount) AS total_spent
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
WHERE o.status = 'Completed'
GROUP BY c.customer_name
ORDER BY total_spent DESC;

SELECT AVG(amount) AS avg_order_value
FROM orders
WHERE status = 'Completed';


SELECT 
    c.customer_name
FROM customers c
LEFT JOIN orders o ON c.customer_id = o.customer_id
WHERE o.order_id IS NULL;


SELECT 
    c.city,
    COUNT(o.order_id) AS total_orders,
    SUM(o.amount) AS revenue
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.city;