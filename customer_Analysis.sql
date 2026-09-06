create database Customer_Behaviour;
Use customer_behaviour;
-- retriving table
select * from customer_shopping;


-- Solving the problems
-- 1.. Display specific columns
SELECT customer_id, age, gender, purchase_amount
FROM customer_shopping;

-- 2. total sales by category
SELECT category,
       SUM(purchase_amount) AS total_sales
FROM customer_shopping
GROUP BY category
ORDER BY total_sales DESC;

-- 3.Top 5 customers by spending
SELECT customer_id,
       SUM(purchase_amount) AS total_spent
FROM customer_shopping
GROUP BY customer_id
ORDER BY total_spent DESC
LIMIT 5;

-- 4.Customers spending more than average
SELECT *
FROM customer_shopping
WHERE purchase_amount >
      (SELECT AVG(purchase_amount)
       FROM customer_shopping);
       
-- 5.Average purchase by gender
SELECT gender,
       AVG(purchase_amount) AS avg_purchase
FROM customer_shopping
GROUP BY gender;

-- 6.Categories with sales above 50,000
SELECT category,
       SUM(purchase_amount) AS total_sales
FROM customer_shopping
GROUP BY category
HAVING SUM(purchase_amount) > 50000;

-- 7. Second-highest purchase
SELECT MAX(purchase_amount) AS second_highest
FROM customer_shopping
WHERE purchase_amount < (
    SELECT MAX(purchase_amount)
    FROM customer_shopping
);

-- 8.Rank customers by spending 
SELECT customer_id,
       purchase_amount,
       RANK() OVER (
           ORDER BY purchase_amount DESC
       ) AS spending_rank
FROM customer_shopping;

-- 9. Categorize customers by purchase amount
SELECT customer_id,
       purchase_amount,
       CASE
           WHEN purchase_amount >= 100 THEN 'High'
           WHEN purchase_amount >= 50 THEN 'Medium'
           ELSE 'Low'
       END AS customer_segment
FROM customer_shopping;

-- 10. Number of customers by gender
SELECT gender,
       COUNT(*) AS customer_count
FROM customer_shopping
GROUP BY gender;