SELECT
    r.review_id,
    r.date,
    r.stars AS review_stars,
    r.text AS review_text,
    r.useful AS review_useful,
    r.funny AS review_funny,
    r.cool AS review_cool,

    b.business_id,
    b.name AS business_name,
    b.address,
    b.city,
    b.state,
    b.postal_code,
    b.latitude,
    b.longitude,
    b.categories,
    b.review_count AS business_review_count,
    b.stars AS business_stars,
    b.is_open,
    b.attributes,
    b.hours,

    u.user_id,
    u.name AS user_name,
    u.review_count AS user_review_count,
    u.yelping_since,
    u.friends,
    u.useful AS user_useful,
    u.funny AS user_funny,
    u.cool AS user_cool,
    u.fans,
    u.elite,
    u.average_stars AS user_average_stars,
    u.compliment_hot,
    u.compliment_more,
    u.compliment_profile,
    u.compliment_cute,
    u.compliment_list,
    u.compliment_plain,
    u.compliment_funny,
    u.compliment_cool,
    u.compliment_writer,
    u.compliment_photos,

    tip.compliment_count,
    tip.text AS tip_text,
    tip.date AS tip_date,

    ch.checkin_dates,

    t.date AS temperature_date,
    t.min_temperature,
    t.max_temperature,
    t.normal_min_temperature,
    t.normal_max_temperature,

    p.date AS precipitation_date,
    p.precipitation,
    p.precipitation_normal,

    cov.highlights,
    cov.delivery_or_takeout,
    cov.grubhub_enabled,
    cov.call_to_action_enabled,
    cov.request_a_quote_enabled,
    cov.covid_banner,
    cov.temporary_closed_until,
    cov.virtual_services_offered

FROM YELP_FILES.ODS.REVIEW r

JOIN YELP_FILES.ODS.BUSINESS b
    ON r.business_id = b.business_id

JOIN YELP_FILES.ODS.USER u
    ON r.user_id = u.user_id

JOIN YELP_FILES.ODS.TIP tip
    ON b.business_id = tip.business_id

JOIN YELP_FILES.ODS.CHECKIN ch
    ON b.business_id = ch.business_id

JOIN YELP_FILES.ODS.COVID cov
    ON b.business_id = cov.business_id

JOIN YELP_FILES.ODS.TEMPERATURE t
    ON TO_DATE(r.date) = t.date

JOIN YELP_FILES.ODS.PRECIPITATION p
    ON CONTAINS(ch.checkin_dates, TO_VARCHAR(p.date))

LIMIT 10;
