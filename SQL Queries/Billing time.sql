/*
 * What is the average delivery time between order and shipment?
*/
SELECT
    ROUND(AVG(o.shipped_date - o.order_date), 2) AS avg_delivery_days
FROM
    orders o
WHERE
    o.shipped_date IS NOT NULL;
/*
On which days or months do you make the most sales?
*/
SELECT
    EXTRACT(MONTH FROM o.order_date) AS month,
    COUNT(o.order_id) AS total_sales
FROM
    orders o
GROUP BY
    EXTRACT(MONTH FROM o.order_date)
ORDER BY
    total_sales DESC;
/*
Which products have a shorter life cycle in inventory before being sold?
*/
SELECT
    p.product_name,
    AVG(o.shipped_date - o.order_date) AS avg_life_cycle
FROM
    products p
JOIN
    order_details od ON p.product_id = od.product_id
JOIN
    orders o ON od.order_id = o.order_id
WHERE
    o.shipped_date IS NOT NULL
GROUP BY
    p.product_name
ORDER BY
    avg_life_cycle ASC
LIMIT 5;


