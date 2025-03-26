-- dim_job dimension
DROP TABLE IF EXISTS dim_job;
CREATE TABLE dim_job (
    job_id SERIAL PRIMARY KEY,
    job_value TEXT UNIQUE NOT NULL
);
-- Insert values into dim_job
INSERT INTO dim_job (job_value) VALUES ('admin.');
INSERT INTO dim_job (job_value) VALUES ('blue-collar');
INSERT INTO dim_job (job_value) VALUES ('entrepreneur');
INSERT INTO dim_job (job_value) VALUES ('housemaid');
INSERT INTO dim_job (job_value) VALUES ('management');
INSERT INTO dim_job (job_value) VALUES ('retired');
INSERT INTO dim_job (job_value) VALUES ('self-employed');
INSERT INTO dim_job (job_value) VALUES ('services');
INSERT INTO dim_job (job_value) VALUES ('student');
INSERT INTO dim_job (job_value) VALUES ('technician');
INSERT INTO dim_job (job_value) VALUES ('unemployed');

-- dim_marital dimension
DROP TABLE IF EXISTS dim_marital;
CREATE TABLE dim_marital (
    marital_id SERIAL PRIMARY KEY,
    marital_value TEXT UNIQUE NOT NULL
);
-- Insert values into dim_marital
INSERT INTO dim_marital (marital_value) VALUES ('divorced');
INSERT INTO dim_marital (marital_value) VALUES ('married');
INSERT INTO dim_marital (marital_value) VALUES ('single');

-- dim_education dimension
DROP TABLE IF EXISTS dim_education;
CREATE TABLE dim_education (
    education_id SERIAL PRIMARY KEY,
    education_value TEXT UNIQUE NOT NULL
);
-- Insert values into dim_education
INSERT INTO dim_education (education_value) VALUES ('basic.4y');
INSERT INTO dim_education (education_value) VALUES ('basic.6y');
INSERT INTO dim_education (education_value) VALUES ('basic.9y');
INSERT INTO dim_education (education_value) VALUES ('high.school');
INSERT INTO dim_education (education_value) VALUES ('illiterate');
INSERT INTO dim_education (education_value) VALUES ('professional.course');
INSERT INTO dim_education (education_value) VALUES ('university.degree');

-- dim_contact dimension
DROP TABLE IF EXISTS dim_contact;
CREATE TABLE dim_contact (
    contact_id SERIAL PRIMARY KEY,
    contact_value TEXT UNIQUE NOT NULL
);
-- Insert values into dim_contact
INSERT INTO dim_contact (contact_value) VALUES ('cellular');
INSERT INTO dim_contact (contact_value) VALUES ('telephone');

-- dim_poutcome dimension
DROP TABLE IF EXISTS dim_poutcome;
CREATE TABLE dim_poutcome (
    poutcome_id SERIAL PRIMARY KEY,
    poutcome_value TEXT UNIQUE NOT NULL
);
-- Insert values into dim_poutcome
INSERT INTO dim_poutcome (poutcome_value) VALUES ('failure');
INSERT INTO dim_poutcome (poutcome_value) VALUES ('nonexistent');
INSERT INTO dim_poutcome (poutcome_value) VALUES ('success');

