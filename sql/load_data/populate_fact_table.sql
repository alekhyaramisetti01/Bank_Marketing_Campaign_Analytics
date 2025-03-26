INSERT INTO bank_marketing_fact (
    age, campaign, pdays, previous, emp_var_rate,
    cons_price_idx, cons_conf_idx, euribor3m, nr_employed, y,
    job_id, marital_id, education_id, contact_id, poutcome_id
)
SELECT 
    bm.age,
    bm.campaign,
    bm.pdays,
    bm.previous,
    bm.emp_var_rate,
    bm.cons_price_idx,
    bm.cons_conf_idx,
    bm.euribor3m,
    bm.nr_employed,
    bm.y,

    dj.job_id,
    dm.marital_id,
    de.education_id,
    dc.contact_id,
    dp.poutcome_id

FROM bank_marketing bm
LEFT JOIN dim_job dj ON bm.job = dj.job_value
LEFT JOIN dim_marital dm ON bm.marital = dm.marital_value
LEFT JOIN dim_education de ON bm.education = de.education_value
LEFT JOIN dim_contact dc ON bm.contact = dc.contact_value
LEFT JOIN dim_poutcome dp ON bm.poutcome = dp.poutcome_value;
