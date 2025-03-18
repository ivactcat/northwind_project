/*
Which regions or countries generate the most sales?
*/
SELECT
    c.country,
    SUM(od.quantity * od.unit_price * (1 - od.discount)) AS total_sales
FROM
    customers c
INNER JOIN
    orders o ON c.customer_id = o.customer_id
INNER JOIN
    order_details od ON o.order_id = od.order_id
GROUP BY
    c.country
ORDER BY
    total_sales DESC;

/*
Are there significant differences in product preferences by location?
*/
SELECT
    c.country,
    p.product_name,
    SUM(od.quantity) AS total_sold
FROM
    customers c
INNER JOIN
    orders o ON c.customer_id = o.customer_id
INNER JOIN
    order_details od ON o.order_id = od.order_id
INNER JOIN
    products p ON od.product_id = p.product_id
GROUP BY
    c.country, p.product_name
ORDER BY
    c.country, total_sold DESC;
/*
What are the largest international orders and which products sell the most in each region?
*/
SELECT
    o.order_id,
    c.company_name,
    c.country AS customer_country,
    p.product_name,
    od.quantity,
    od.unit_price,
    od.discount,
    (od.quantity * od.unit_price * (1 - od.discount)) AS total_product_value
FROM
    orders o
INNER JOIN
    customers c ON o.customer_id = c.customer_id
INNER JOIN
    order_details od ON o.order_id = od.order_id
INNER JOIN
    products p ON od.product_id = p.product_id
WHERE
    c.country != 'USA'  -- Asumiendo que la empresa está en 'USA' (ajustar según sea necesario)
ORDER BY
    total_product_value DESC
LIMIT 5;