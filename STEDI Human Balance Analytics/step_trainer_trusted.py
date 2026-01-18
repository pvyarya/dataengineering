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

# Script generated for node Step Trainer Landing
StepTrainerLanding_node1768748062038 = glueContext.create_dynamic_frame.from_catalog(database="stedi_s3_pa", table_name="step_trainer_landing", transformation_ctx="StepTrainerLanding_node1768748062038")

# Script generated for node Customer Curated
CustomerCurated_node1768748063707 = glueContext.create_dynamic_frame.from_catalog(database="stedi_s3_pa", table_name="customers_curated", transformation_ctx="CustomerCurated_node1768748063707")

# Script generated for node SQL Query
SqlQuery3146 = '''
SELECT s.*
FROM step_trainer_landing s
INNER JOIN customers_curated c
ON c.serialnumber = s.serialnumber

'''
SQLQuery_node1768748107573 = sparkSqlQuery(glueContext, query = SqlQuery3146, mapping = {"step_trainer_landing":StepTrainerLanding_node1768748062038, "customers_curated":CustomerCurated_node1768748063707}, transformation_ctx = "SQLQuery_node1768748107573")

# Script generated for node Amazon S3
EvaluateDataQuality().process_rows(frame=SQLQuery_node1768748107573, ruleset=DEFAULT_DATA_QUALITY_RULESET, publishing_options={"dataQualityEvaluationContext": "EvaluateDataQuality_node1768744042102", "enableDataQualityResultsPublishing": True}, additional_options={"dataQualityResultsPublishing.strategy": "BEST_EFFORT", "observations.scope": "ALL"})
AmazonS3_node1768748129980 = glueContext.getSink(path="s3://stedi-s3-pa/step_trainer_trusted/", connection_type="s3", updateBehavior="UPDATE_IN_DATABASE", partitionKeys=[], enableUpdateCatalog=True, transformation_ctx="AmazonS3_node1768748129980")
AmazonS3_node1768748129980.setCatalogInfo(catalogDatabase="stedi_s3_pa",catalogTableName="step_trainer_trusted")
AmazonS3_node1768748129980.setFormat("json")
AmazonS3_node1768748129980.writeFrame(SQLQuery_node1768748107573)
job.commit()