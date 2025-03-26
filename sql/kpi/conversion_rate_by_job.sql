-- 👥 KPI 2: Conversion Rate by Job
-- Business Problem: Which customer job segments are most responsive?
-- Business Insight: Focus future campaigns on job roles with higher conversion rates.

SELECT 
    dj.job_value,
    COUNT(*) AS total_customers,
    SUM(CASE WHEN y = 'yes' THEN 1 ELSE 0 END) AS subscribed,
    ROUND(100.0 * SUM(CASE WHEN y = 'yes' THEN 1 ELSE 0 END) / COUNT(*), 2) AS conversion_rate_percent
FROM bank_marketing_fact bmf
JOIN dim_job dj ON bmf.job_id = dj.job_id
GROUP BY dj.job_value
ORDER BY conversion_rate_percent DESC;
