-- 🔁 KPI 5: Conversion Rate by Previous Campaign Outcome
-- Business Problem: Does a customer's past campaign outcome affect their likelihood to convert now?
-- Business Insight: Prioritize follow-ups on customers who had positive or no prior interactions.

SELECT 
    dp.poutcome_value,
    COUNT(*) AS total_customers,
    SUM(CASE WHEN y = 'yes' THEN 1 ELSE 0 END) AS subscribed,
    ROUND(100.0 * SUM(CASE WHEN y = 'yes' THEN 1 ELSE 0 END) / COUNT(*), 2) AS conversion_rate_percent
FROM bank_marketing_fact bmf
JOIN dim_poutcome dp ON bmf.poutcome_id = dp.poutcome_id
GROUP BY dp.poutcome_value
ORDER BY conversion_rate_percent DESC;
