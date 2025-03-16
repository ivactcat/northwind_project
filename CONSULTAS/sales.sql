/*
1. sales per year
*/
SELECT EXTRACT(YEAR FROM o.order_date) AS year, 
       SUM(od.quantity * p.unit_price) AS total_sales
FROM Orders as o
JOIN Order_Details od ON o.order_id = od.order_id
JOIN Products p ON od.product_id = p.product_id
GROUP BY EXTRACT(YEAR FROM o.order_date)
ORDER BY year;

/*
2. Sales per quarter
*/

SELECT EXTRACT(YEAR FROM o.order_date) AS year, 
       EXTRACT(QUARTER FROM o.order_date) AS quarter, 
       SUM(order_details.quantity * p.unit_price) AS total_sales
FROM Orders o
JOIN Order_details  ON o.order_id = order_details.order_id
JOIN Products p ON order_details.product_id = p.product_id
GROUP BY EXTRACT(YEAR FROM o.order_date), EXTRACT(QUARTER FROM o.order_date)
ORDER BY year, quarter;

/*
3. sales per month
*/

SELECT EXTRACT(YEAR FROM o.order_date) AS year, 
       EXTRACT(MONTH FROM o.order_date) AS month, 
       SUM(order_details.quantity * p.unit_price) AS total_sales
FROM Orders o
JOIN Order_Details  ON o.order_id = order_details.order_id
JOIN Products p ON order_details.product_id = p.product_id
GROUP BY EXTRACT(YEAR FROM o.order_date), EXTRACT(MONTH FROM o.order_date)
ORDER BY year, month;

/*
4. Ventas por año y categoría de producto
*/
SELECT EXTRACT(YEAR FROM o.order_date) AS year,
       c.category_name,
       SUM(order_details.quantity * p.unit_price) AS total_sales
FROM Orders as o
JOIN Order_Details  ON o.order_id = order_details.order_id
JOIN Products p ON order_details.product_id = p.product_id
JOIN Categories as c ON p.category_id = c.category_id
GROUP BY EXTRACT(YEAR FROM o.order_date), c.category_name
ORDER BY year, c.category_name;

