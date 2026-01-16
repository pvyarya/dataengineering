USE DATABASE YELP_FILES;
USE SCHEMA DWH;

CREATE OR REPLACE TABLE DWH.DIM_USER AS
SELECT
    user_id,
    name AS user_name,
    yelping_since,
    friends,
    review_count,
    useful,
    funny,
    cool,
    fans,
    elite,
    average_stars,
    compliment_hot,
    compliment_more,
    compliment_profile,
    compliment_cute,
    compliment_list,
    compliment_plain,
    compliment_funny,
    compliment_cool,
    compliment_writer,
    compliment_photos
FROM YELP_FILES.ODS.USER;

CREATE OR REPLACE TABLE DWH.DIM_BUSINESS AS
SELECT
    business_id,
    name AS business_name,
    address,
    city,
    state,
    postal_code,
    latitude,
    longitude,
    categories,
    review_count,
    stars AS avg_stars,
    is_open,
    attributes,
    hours
FROM YELP_FILES.ODS.BUSINESS;

CREATE OR REPLACE TABLE DWH.DIM_DATE AS
SELECT DISTINCT
    TO_DATE(DATE) AS date_id,
    DAY(TO_DATE(DATE)) AS day,
    MONTH(TO_DATE(DATE)) AS month,
    YEAR(TO_DATE(DATE)) AS year,
    DAYOFWEEK(TO_DATE(DATE)) AS weekday
FROM YELP_FILES.ODS.REVIEW;

CREATE OR REPLACE TABLE DWH.DIM_COVID AS
SELECT
    business_id,
    highlights,
    delivery_or_takeout,
    grubhub_enabled,
    call_to_action_enabled,
    request_a_quote_enabled,
    covid_banner,
    temporary_closed_until,
    virtual_services_offered
FROM YELP_FILES.ODS.COVID;

CREATE OR REPLACE TABLE DWH.DIM_TIP AS
SELECT      
    business_id,
    user_id,
    text AS tip_text,
    compliment_count,
    date AS tip_date
FROM YELP_FILES.ODS.TIP;

CREATE OR REPLACE TABLE DWH.DIM_CHECKIN AS
SELECT
    business_id,
    checkin_dates
FROM YELP_FILES.ODS.CHECKIN;

CREATE OR REPLACE TABLE DWH.FACT_REVIEW AS
SELECT
    review_id,
    user_id,
    business_id,
    TO_DATE(date) AS date_id,
    stars,
    useful,
    funny,
    cool
FROM YELP_FILES.ODS.REVIEW;


CREATE OR REPLACE TABLE DIM_WEATHER (
    date_id DATE PRIMARY KEY,
    min_temp FLOAT,
    max_temp FLOAT,
    normal_min FLOAT,
    normal_max FLOAT,
    precipitation STRING,
    precipitation_normal FLOAT
);

INSERT INTO YELP_FILES.DWH.DIM_WEATHER (
    date_id,
    min_temp,
    max_temp,
    normal_min,
    normal_max,
    precipitation,
    precipitation_normal
)
SELECT
    t.date AS date_id,
    t.min_temperature AS min_temp,
    t.max_temperature AS max_temp,
    t.normal_min_temperature AS normal_min,
    t.normal_max_temperature AS normal_max,
    p.precipitation,
    p.precipitation_normal
FROM YELP_FILES.ODS.TEMPERATURE AS t
JOIN YELP_FILES.ODS.PRECIPITATION AS p
    ON t.date = p.date;
