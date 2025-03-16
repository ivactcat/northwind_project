
/*
 * The most sold products by quantity 
 */
SELECT
    products.product_name,
    SUM(od.Quantity) AS TotalQuantity
FROM
    order_details AS od
INNER JOIN
    products ON od.product_id = products.product_id
GROUP BY
    products.product_name
ORDER BY
    TotalQuantity DESC
LIMIT 5;

/*
 *This query calculates the total sales value for each product, considering the quantity sold, the unit price, and the discount applied, and returns the five products with the highest sales value.
 */
SELECT
    p.product_name,
    SUM(od.quantity * od.unit_price * (1 - od.discount)) AS total_sales
FROM
    order_details od
INNER JOIN
    products p ON od.product_id = p.product_id
GROUP BY
    p.product_name
ORDER BY
    total_sales DESC
LIMIT 5;

/*
 * Which products have the highest profitability? (comparing cost to sales price)
 */
SELECT
    p.product_name,
    p.unit_price,
    p.reorder_level, 
    (p.unit_price - p.reorder_level) AS profit_margin,
    CASE
        WHEN p.reorder_level = 0 THEN NULL
        ELSE ((p.unit_price - p.reorder_level) / p.reorder_level) * 100
    END AS profit_percentage
FROM
    products p
WHERE
    p.reorder_level > 0 
ORDER BY
    profit_margin DESC
LIMIT 5;

/*
 *Categories with the highest sales by quantity (in units)
*/

SELECT
    c.category_name,
    SUM(od.quantity) AS total_quantity
FROM
    order_details od
INNER JOIN
    products p ON od.product_id = p.product_id
INNER JOIN
    categories c ON p.category_id = c.category_id
GROUP BY
    c.category_name
ORDER BY
    total_quantity DESC
LIMIT 5;
/*
 *Categories with the highest sales by total value (sales price * quantity)
 */
SELECT
    c.category_name,
    SUM(od.quantity * od.unit_price * (1 - od.discount)) AS total_sales
FROM
    order_details od
INNER JOIN
    products p ON od.product_id = p.product_id
INNER JOIN
    categories c ON p.category_id = c.category_id
GROUP BY
    c.category_name
ORDER BY
    total_sales DESC
LIMIT 5;

/*
Customers who buy the most by quantity (in units)
*/
SELECT
    c.customer_id,
    c.company_name,
    SUM(od.quantity) AS total_quantity
FROM
    order_details od
INNER JOIN
    orders o ON od.order_id = o.order_id
INNER JOIN
    customers c ON o.customer_id = c.customer_id
GROUP BY
    c.customer_id, c.company_name
ORDER BY
    total_quantity DESC
LIMIT 5;

/*
Customers who buy the most by total value (sales price * quantity)
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
Which products have the highest frequency of purchases?
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
LIMIT 8;
