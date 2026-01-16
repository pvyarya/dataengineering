USE DATABASE YELP_FILES;
USE SCHEMA ODS;

CREATE OR REPLACE TABLE BUSINESS (
    business_id STRING,
    name STRING,
    address STRING,
    city STRING,
    state STRING,
    postal_code STRING,
    latitude FLOAT,
    longitude FLOAT,
    stars FLOAT,
    review_count INTEGER,
    is_open INTEGER,
    categories STRING,
    attributes VARIANT,
    hours VARIANT
);

INSERT INTO YELP_FILES.ODS.BUSINESS
SELECT
    BUSINESSJSON:business_id::STRING AS business_id,
    BUSINESSJSON:name::STRING AS name,
    BUSINESSJSON:address::STRING AS address,
    BUSINESSJSON:city::STRING AS city,
    BUSINESSJSON:state::STRING AS state,
    BUSINESSJSON:postal_code::STRING AS postal_code,
    BUSINESSJSON:latitude::FLOAT AS latitude,
    BUSINESSJSON:longitude::FLOAT AS longitude,
    BUSINESSJSON:stars::FLOAT AS stars,
    BUSINESSJSON:review_count::INTEGER AS review_count,
    BUSINESSJSON:is_open::INTEGER AS is_open,
    BUSINESSJSON:categories::STRING AS categories,
    BUSINESSJSON:attributes AS attributes,
    BUSINESSJSON:hours AS hours
FROM YELP_FILES.STAGING_SCHEMA.BUSINESS;

SELECT *
FROM YELP_FILES.ODS.BUSINESS
LIMIT 10;

-------------------------------------------------------------------------------------------------------------------------------------

CREATE OR REPLACE TABLE TIP (
    business_id STRING,
    user_id STRING,
    text STRING,
    date TIMESTAMP,
    compliment_count INTEGER
);

INSERT INTO YELP_FILES.ODS.TIP
SELECT
    TIPJSON:business_id::STRING AS business_id,
    TIPJSON:user_id::STRING AS user_id,
    TIPJSON:text::STRING AS text,
    TIPJSON:date::TIMESTAMP AS date,
    TIPJSON:compliment_count::INTEGER AS compliment_count
FROM YELP_FILES.STAGING_SCHEMA.TIP;

SELECT *
FROM YELP_FILES.ODS.TIP
LIMIT 10;

----------------------------------------------------------------------------------------------------------------------------------------

CREATE OR REPLACE TABLE REVIEW (
    review_id STRING,
    business_id STRING,
    user_id STRING,
    stars INTEGER,
    useful INTEGER,
    funny INTEGER,
    cool INTEGER,
    text STRING,
    date TIMESTAMP
);

INSERT INTO YELP_FILES.ODS.REVIEW
SELECT
    REVIEWJSON:review_id::STRING AS review_id,
    REVIEWJSON:business_id::STRING AS business_id,
    REVIEWJSON:user_id::STRING AS user_id,
    REVIEWJSON:stars::INTEGER AS stars,
    REVIEWJSON:useful::INTEGER AS useful,
    REVIEWJSON:funny::INTEGER AS funny,
    REVIEWJSON:cool::INTEGER AS cool,
    REVIEWJSON:text::STRING AS text,
    REVIEWJSON:date::TIMESTAMP AS date
FROM YELP_FILES.STAGING_SCHEMA.REVIEW;


SELECT *
FROM YELP_FILES.ODS.REVIEW
LIMIT 10;

------------------------------------------------------------------------------------------------------------------------------------

CREATE OR REPLACE TABLE USER (
    user_id STRING,
    name STRING,
    review_count INTEGER,
    yelping_since TIMESTAMP,
    useful INTEGER,
    funny INTEGER,
    cool INTEGER,
    fans INTEGER,
    average_stars FLOAT,
    elite STRING,
    friends STRING,
    compliment_hot INTEGER,
    compliment_more INTEGER,
    compliment_profile INTEGER,
    compliment_cute INTEGER,
    compliment_list INTEGER,
    compliment_note INTEGER,
    compliment_plain INTEGER,
    compliment_cool INTEGER,
    compliment_funny INTEGER,
    compliment_writer INTEGER,
    compliment_photos INTEGER
);

INSERT INTO YELP_FILES.ODS.USER
SELECT
    USERJSON:user_id::STRING AS user_id,
    USERJSON:name::STRING AS name,
    USERJSON:review_count::INTEGER AS review_count,
    USERJSON:yelping_since::TIMESTAMP AS yelping_since,
    USERJSON:useful::INTEGER AS useful,
    USERJSON:funny::INTEGER AS funny,
    USERJSON:cool::INTEGER AS cool,
    USERJSON:fans::INTEGER AS fans,
    USERJSON:average_stars::FLOAT AS average_stars,
    USERJSON:elite::STRING AS elite,
    USERJSON:friends::STRING AS friends,
    USERJSON:compliment_hot::INTEGER AS compliment_hot,
    USERJSON:compliment_more::INTEGER AS compliment_more,
    USERJSON:compliment_profile::INTEGER AS compliment_profile,
    USERJSON:compliment_cute::INTEGER AS compliment_cute,
    USERJSON:compliment_list::INTEGER AS compliment_list,
    USERJSON:compliment_note::INTEGER AS compliment_note,
    USERJSON:compliment_plain::INTEGER AS compliment_plain,
    USERJSON:compliment_cool::INTEGER AS compliment_cool,
    USERJSON:compliment_funny::INTEGER AS compliment_funny,
    USERJSON:compliment_writer::INTEGER AS compliment_writer,
    USERJSON:compliment_photos::INTEGER AS compliment_photos
FROM YELP_FILES.STAGING_SCHEMA.USER;


SELECT *
FROM YELP_FILES.ODS.USER
LIMIT 10;

-----------------------------------------------------------------------------------------------------------------------------
CREATE OR REPLACE TABLE CHECKIN (
    business_id STRING,
    checkin_dates STRING
);

INSERT INTO YELP_FILES.ODS.CHECKIN
SELECT
    CHECKINJSON:business_id::STRING AS business_id,
    CHECKINJSON:date::STRING AS checkin_dates
FROM YELP_FILES.STAGING_SCHEMA.CHECKIN;

SELECT *
FROM YELP_FILES.ODS.CHECKIN
LIMIT 10;

------------------------------------------------------------------------------------------------------------------

CREATE OR REPLACE TABLE COVID (
    business_id STRING,
    call_to_action_enabled STRING,
    covid_banner STRING,
    grubhub_enabled STRING,
    request_a_quote_enabled STRING,
    temporary_closed_until STRING,
    virtual_services_offered STRING,
    delivery_or_takeout STRING,
    highlights STRING
);

INSERT INTO YELP_FILES.ODS.COVID
SELECT
    COVIDJSON:business_id::STRING AS business_id,
    COVIDJSON:"Call To Action enabled"::STRING AS call_to_action_enabled,
    COVIDJSON:"Covid Banner"::STRING AS covid_banner,
    COVIDJSON:"Grubhub enabled"::STRING AS grubhub_enabled,
    COVIDJSON:"Request a Quote Enabled"::STRING AS request_a_quote_enabled,
    COVIDJSON:"Temporary Closed Until"::STRING AS temporary_closed_until,
    COVIDJSON:"Virtual Services Offered"::STRING AS virtual_services_offered,
    COVIDJSON:"delivery or takeout"::STRING AS delivery_or_takeout,
    COVIDJSON:"highlights"::STRING AS highlights
FROM YELP_FILES.STAGING_SCHEMA.COVID;

SELECT *
FROM YELP_FILES.ODS.COVID
LIMIT 10;