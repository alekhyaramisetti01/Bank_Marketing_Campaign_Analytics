-- 🎓 KPI 3: Conversion Rate by Education Level
-- Business Problem: How does educational background affect campaign success?
-- Business Insight: Tailor campaigns or messaging based on the educational level of the target audience.

SELECT 
    de.education_value,
    COUNT(*) AS total_customers,
    SUM(CASE WHEN y = 'yes' THEN 1 ELSE 0 END) AS subscribed,
    ROUND(100.0 * SUM(CASE WHEN y = 'yes' THEN 1 ELSE 0 END) / COUNT(*), 2) AS conversion_rate_percent
FROM bank_marketing_fact bmf
JOIN dim_education de ON bmf.education_id = de.education_id
GROUP BY de.education_value
ORDER BY conversion_rate_percent DESC;
