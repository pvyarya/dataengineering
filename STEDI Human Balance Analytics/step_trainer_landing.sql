CREATE EXTERNAL TABLE IF NOT EXISTS stedi_s3_pa.step_trainer_landing (
    sensorReadingTime BIGINT,
    serialNumber STRING,
    distanceFromObject DOUBLE
)
ROW FORMAT SERDE 'org.openx.data.jsonserde.JsonSerDe'
LOCATION 's3://stedi-s3-pa/step_trainer_landing/';
