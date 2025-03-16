/*
• Which employees handle the most orders?
*/
SELECT
    e.employee_id,
    e.first_name || ' ' || e.last_name AS employee_name,
    COUNT(o.order_id) AS total_orders
FROM
    orders o
INNER JOIN
    employees e ON o.employee_id = e.employee_id
GROUP BY
    e.employee_id, e.first_name, e.last_name
ORDER BY
    total_orders DESC;

/*
employees who generate more sales
*/
SELECT
    e.employee_id,
    e.first_name || ' ' || e.last_name AS employee_name,
    SUM(od.quantity * od.unit_price * (1 - od.discount)) AS total_sales
FROM
    order_details od
INNER JOIN
    orders o ON od.order_id = o.order_id
INNER JOIN
    employees e ON o.employee_id = e.employee_id
GROUP BY
    e.employee_id, e.first_name, e.last_name
ORDER BY
    total_sales DESC;

/*
What is the average sales per employee?
*/
SELECT
    e.employee_id,
    e.first_name || ' ' || e.last_name AS employee_name,
    SUM(od.quantity * od.unit_price * (1 - od.discount)) AS total_sales,
    COUNT(DISTINCT o.order_id) AS total_orders,
    SUM(od.quantity * od.unit_price * (1 - od.discount)) / COUNT(DISTINCT o.order_id) AS average_sales_per_order
FROM
    order_details od
INNER JOIN
    orders o ON od.order_id = o.order_id
INNER JOIN
    employees e ON o.employee_id = e.employee_id
GROUP BY
    e.employee_id, e.first_name, e.last_name
ORDER BY
    average_sales_per_order DESC;

/*
Are there consistently high performers in all categories?
*/
SELECT
    e.employee_id,
    e.first_name || ' ' || e.last_name AS employee_name,
    COUNT(DISTINCT o.order_id) AS total_orders,
    SUM(od.quantity * od.unit_price * (1 - od.discount)) AS total_sales,
    SUM(od.quantity * od.unit_price * (1 - od.discount)) / COUNT(DISTINCT o.order_id) AS average_sales_per_order
FROM
    order_details od
INNER JOIN
    orders o ON od.order_id = o.order_id
INNER JOIN
    employees e ON o.employee_id = e.employee_id
GROUP BY
    e.employee_id, e.first_name, e.last_name
HAVING
    COUNT(DISTINCT o.order_id) > 10  -- Umbral de pedidos gestionados (ajustable)
    AND SUM(od.quantity * od.unit_price * (1 - od.discount)) > 10000  -- Umbral de ventas totales (ajustable)
    AND (SUM(od.quantity * od.unit_price * (1 - od.discount)) / COUNT(DISTINCT o.order_id)) > 200  -- Umbral de promedio de ventas por pedido (ajustable)
ORDER BY
    total_sales DESC;

/*
Which employees have a better customer service record?
*/
SELECT
    e.employee_id,
    e.first_name || ' ' || e.last_name AS employee_name,
    COUNT(o.order_id) AS total_orders,
    AVG(DATE_PART('day', o.shipped_date - o.order_date)) AS average_delivery_time
FROM
    orders o
INNER JOIN
    employees e ON o.employee_id = e.employee_id
WHERE
    o.shipped_date IS NOT NULL  -- Solo contar los pedidos que se hayan enviado
GROUP BY
    e.employee_id, e.first_name, e.last_name
HAVING
    COUNT(o.order_id) > 10  -- Empleados con más de 10 pedidos gestionados (ajustable)
ORDER BY
    average_delivery_time ASC, total_orders DESC;