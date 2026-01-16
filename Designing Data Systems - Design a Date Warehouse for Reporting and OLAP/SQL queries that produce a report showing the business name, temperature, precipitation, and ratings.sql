SELECT
    b.business_name,
    w.min_temp,
    w.max_temp,
    w.precipitation,
    r.stars AS review_rating
FROM YELP_FILES.DWH.FACT_REVIEW r
JOIN YELP_FILES.DWH.DIM_BUSINESS b
    ON r.business_id = b.business_id
JOIN YELP_FILES.DWH.DIM_DATE d
    ON r.date_id = d.date_id
JOIN YELP_FILES.DWH.DIM_WEATHER w
    ON r.date_id = w.date_id
LIMIT 50;
