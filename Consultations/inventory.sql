/*
•What are the products with the highest available stock and the lowest stock?
*/
SELECT
    p.product_name,
    p.units_in_stock
FROM
    products p
ORDER BY
    p.units_in_stock DESC
LIMIT 5;  -- the producto more stock

/*
•Which products are likely to be out of stock based on sales trends?
*/
SELECT
    p.product_name,
    p.units_in_stock,
    EXTRACT(MONTH FROM o.order_date) AS month,
    SUM(od.quantity) AS total_sold_monthly,
    (p.units_in_stock / NULLIF(SUM(od.quantity), 0)) AS stock_to_sales_ratio
FROM
    products p
INNER JOIN
    order_details od ON p.product_id = od.product_id
INNER JOIN
    orders o ON od.order_id = o.order_id
GROUP BY
    p.product_name, p.units_in_stock, EXTRACT(MONTH FROM o.order_date)
ORDER BY
    stock_to_sales_ratio ASC, total_sold_monthly DESC;

/*
 * Are there products that are in high demand but not often available?
 */
SELECT
    p.product_name,
    p.units_in_stock,
    COALESCE(SUM(od.quantity), 0) AS total_sold,
    CASE
        WHEN p.units_in_stock < 20 AND COALESCE(SUM(od.quantity), 0) > 100 THEN 'High demand, low stock'
        ELSE 'Normal'
    END AS stock_issue
FROM
    products p
LEFT JOIN
    order_details od ON p.product_id = od.product_id
LEFT JOIN
    orders o ON od.order_id = o.order_id
GROUP BY
    p.product_name, p.units_in_stock
HAVING
    COALESCE(SUM(od.quantity), 0) > 100
ORDER BY
    total_sold DESC;