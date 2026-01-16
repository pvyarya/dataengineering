USE DATABASE YELP_FILES;
USE SCHEMA ODS;

CREATE OR REPLACE TABLE PRECIPITATION (
    date DATE,
    precipitation STRING,
    precipitation_normal FLOAT
);

INSERT INTO YELP_FILES.ODS.PRECIPITATION
SELECT
    TO_DATE(DATE::STRING, 'YYYYMMDD') AS date,
    PRECIPITATION::STRING AS precipitation,
    PRECIPITATION_NORMAL::FLOAT AS precipitation_normal
FROM YELP_FILES.STAGING_SCHEMA.PRECIPITATION;

SELECT *
FROM YELP_FILES.ODS.PRECIPITATION
LIMIT 10;

------------------------------------------------------------------------

CREATE OR REPLACE TABLE TEMPERATURE (
    date DATE,
    min_temperature FLOAT,
    max_temperature FLOAT,
    normal_min_temperature FLOAT,
    normal_max_temperature FLOAT
);

INSERT INTO YELP_FILES.ODS.TEMPERATURE
SELECT
    TO_DATE(DATE::STRING, 'YYYYMMDD') AS date,
    MIN::FLOAT AS min_temperature,
    MAX::FLOAT AS max_temperature,
    NORMAL_MIN::FLOAT AS normal_min_temperature,
    NORMAL_MAX::FLOAT AS normal_max_temperature
FROM YELP_FILES.STAGING_SCHEMA.TEMPERATURE;

SELECT *
FROM YELP_FILES.ODS.TEMPERATURE
LIMIT 10;