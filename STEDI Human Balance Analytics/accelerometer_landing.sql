CREATE EXTERNAL TABLE IF NOT EXISTS stedi_s3_pa.accelerometer_landing (
    timeStamp BIGINT,
    user STRING,
    x DOUBLE,
    y DOUBLE,
    z DOUBLE
)
ROW FORMAT SERDE 'org.openx.data.jsonserde.JsonSerDe'
LOCATION 's3://stedi-s3-pa/accelerometer_landing/';
