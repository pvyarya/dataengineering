import sys
from awsglue.transforms import *
from awsglue.utils import getResolvedOptions
from pyspark.context import SparkContext
from awsglue.context import GlueContext
from awsglue.job import Job
from awsgluedq.transforms import EvaluateDataQuality
from awsglue import DynamicFrame

def sparkSqlQuery(glueContext, query, mapping, transformation_ctx) -> DynamicFrame:
    for alias, frame in mapping.items():
        frame.toDF().createOrReplaceTempView(alias)
    result = spark.sql(query)
    return DynamicFrame.fromDF(result, glueContext, transformation_ctx)
args = getResolvedOptions(sys.argv, ['JOB_NAME'])
sc = SparkContext()
glueContext = GlueContext(sc)
spark = glueContext.spark_session
job = Job(glueContext)
job.init(args['JOB_NAME'], args)

# Default ruleset used by all target nodes with data quality enabled
DEFAULT_DATA_QUALITY_RULESET = """
    Rules = [
        ColumnCount > 0
    ]
"""

# Script generated for node Customer Trusted
CustomerTrusted_node1768691342928 = glueContext.create_dynamic_frame.from_catalog(database="stedi_s3_pa", table_name="customer_trusted", transformation_ctx="CustomerTrusted_node1768691342928")

# Script generated for node Accelerometer Landing
AccelerometerLanding_node1768691344509 = glueContext.create_dynamic_frame.from_catalog(database="stedi_s3_pa", table_name="accelerometer_landing", transformation_ctx="AccelerometerLanding_node1768691344509")

# Script generated for node SQL Query
SqlQuery3293 = '''
select distinct a.*
from accelerometer_landing AS a
inner join customer_trusted as c
on a.user=c.email
'''
SQLQuery_node1768691404125 = sparkSqlQuery(glueContext, query = SqlQuery3293, mapping = {"accelerometer_landing":AccelerometerLanding_node1768691344509, "customer_trusted":CustomerTrusted_node1768691342928}, transformation_ctx = "SQLQuery_node1768691404125")

# Script generated for node Amazon S3
EvaluateDataQuality().process_rows(frame=SQLQuery_node1768691404125, ruleset=DEFAULT_DATA_QUALITY_RULESET, publishing_options={"dataQualityEvaluationContext": "EvaluateDataQuality_node1768681397285", "enableDataQualityResultsPublishing": True}, additional_options={"dataQualityResultsPublishing.strategy": "BEST_EFFORT", "observations.scope": "ALL"})
AmazonS3_node1768691547452 = glueContext.getSink(path="s3://stedi-s3-pa/accelerometer_trusted/", connection_type="s3", updateBehavior="UPDATE_IN_DATABASE", partitionKeys=[], enableUpdateCatalog=True, transformation_ctx="AmazonS3_node1768691547452")
AmazonS3_node1768691547452.setCatalogInfo(catalogDatabase="stedi_s3_pa",catalogTableName="accelerometer_trusted")
AmazonS3_node1768691547452.setFormat("json")
AmazonS3_node1768691547452.writeFrame(SQLQuery_node1768691404125)
job.commit()