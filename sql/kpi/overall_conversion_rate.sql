-- 📈 KPI 1: Overall Conversion Rate
-- Business Problem: How effective is our marketing campaign overall?
-- Business Insight: If the conversion rate is low, the campaign strategy, audience targeting, or messaging may need to be revised.

SELECT 
    COUNT(*) AS total_customers,
    SUM(CASE WHEN y = 'yes' THEN 1 ELSE 0 END) AS subscribed,
    ROUND(100.0 * SUM(CASE WHEN y = 'yes' THEN 1 ELSE 0 END) / COUNT(*), 2) AS conversion_rate_percent
FROM bank_marketing_fact;
