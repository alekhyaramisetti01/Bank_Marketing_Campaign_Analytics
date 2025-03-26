DROP TABLE IF EXISTS bank_marketing;

CREATE TABLE bank_marketing (
    age INTEGER,
    job TEXT,
    marital TEXT,
    education TEXT,
    "default" TEXT,
    housing TEXT,
    loan TEXT,
    contact TEXT,
    month TEXT,
    day_of_week TEXT,
    campaign INTEGER,
    pdays INTEGER,
    previous INTEGER,
    poutcome TEXT,
    emp_var_rate FLOAT,
    cons_price_idx FLOAT,
    cons_conf_idx FLOAT,
    euribor3m FLOAT,
    nr_employed FLOAT,
    y TEXT
);
