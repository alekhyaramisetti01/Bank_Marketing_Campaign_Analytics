DROP TABLE IF EXISTS bank_marketing_fact;
CREATE TABLE bank_marketing_fact (
    age INTEGER,
    job_id INTEGER REFERENCES dim_job(job_id),
    marital_id INTEGER REFERENCES dim_marital(marital_id),
    education_id INTEGER REFERENCES dim_education(education_id),
    "default" TEXT,
    housing TEXT,
    loan TEXT,
    contact_id INTEGER REFERENCES dim_contact(contact_id),
    month TEXT,
    day_of_week TEXT,
    campaign INTEGER,
    pdays INTEGER,
    previous INTEGER,
    poutcome_id INTEGER REFERENCES dim_poutcome(poutcome_id),
    emp_var_rate FLOAT,
    cons_price_idx FLOAT,
    cons_conf_idx FLOAT,
    euribor3m FLOAT,
    nr_employed FLOAT,
    y TEXT
);