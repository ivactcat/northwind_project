/*
•Who are the customers with the highest revenue generated?
*/
SELECT
    c.customer_id,
    c.company_name,
    SUM(od.quantity * od.unit_price * (1 - od.discount)) AS total_sales
FROM
    order_details od
INNER JOIN
    orders o ON od.order_id = o.order_id
INNER JOIN
    customers c ON o.customer_id = c.customer_id
GROUP BY
    c.customer_id, c.company_name
ORDER BY
    total_sales DESC
LIMIT 5;

/*
•How many products do customers buy, on average, per order?
*/
SELECT
    AVG(total_products) AS average_products_per_order
FROM (
    SELECT
        o.order_id,
        SUM(od.quantity) AS total_products
    FROM
        order_details od
    INNER JOIN
        orders o ON od.order_id = o.order_id
    GROUP BY
        o.order_id
) AS orders_summary;

/*
•How do customer purchases vary over time? (Are there seasonal patterns?)
*/

SELECT
    EXTRACT(YEAR FROM o.order_date) AS year,
    EXTRACT(QUARTER FROM o.order_date) AS quarter,
    SUM(od.quantity * od.unit_price * (1 - od.discount)) AS total_sales
FROM
    order_details od
INNER JOIN
    orders o ON od.order_id = o.order_id
GROUP BY
    year, quarter
ORDER BY
    year, quarter;
/*
 * Which customers take the longest to pay their bills?
 */
SELECT
    c.customer_id,
    c.company_name,
    AVG(EXTRACT(DAY FROM AGE(o.shipped_date, o.order_date))) AS average_days_to_pay
FROM
    orders o
INNER JOIN
    customers c ON o.customer_id = c.customer_id
WHERE
    o.shipped_date IS NOT NULL
GROUP BY
    c.customer_id, c.company_name
ORDER BY
    average_days_to_pay DESC
LIMIT 5;

/*
 *Which customers have recurring orders?
 */

SELECT
    c.customer_id,
    c.company_name,
    COUNT(o.order_id) AS total_orders
FROM
    orders o
INNER JOIN
    customers c ON o.customer_id = c.customer_id
GROUP BY
    c.customer_id, c.company_name
HAVING
    COUNT(o.order_id) > 1
ORDER BY
    total_orders DESC;


