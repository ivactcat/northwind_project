/*
•	Who are the customers who have not made recent purchases?
*/

SELECT c.customer_id , c.Company_Name, c.contact_name 
FROM Customers as c
LEFT JOIN Orders as o ON c.customer_id  = o.customer_id 
WHERE o.Order_date IS NULL
   OR o.Order_date < CURRENT_DATE - INTERVAL '30 days';

