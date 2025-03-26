-- ☎️ KPI 4: Conversion Rate by Contact Method
-- Business Problem: Which contact method is most effective?
-- Business Insight: Optimize marketing spend by focusing on the most effective contact channels.

SELECT 
    dc.contact_value,
    COUNT(*) AS total_customers,
    SUM(CASE WHEN y = 'yes' THEN 1 ELSE 0 END) AS subscribed,
    ROUND(100.0 * SUM(CASE WHEN y = 'yes' THEN 1 ELSE 0 END) / COUNT(*), 2) AS conversion_rate_percent
FROM bank_marketing_fact bmf
JOIN dim_contact dc ON bmf.contact_id = dc.contact_id
GROUP BY dc.contact_value
ORDER BY conversion_rate_percent DESC;
