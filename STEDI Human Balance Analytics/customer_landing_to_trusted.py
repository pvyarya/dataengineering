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

# Script generated for node Customer Landing
CustomerLanding_node1768679801018 = glueContext.create_dynamic_frame.from_catalog(database="stedi_s3_pa", table_name="customer_landing", transformation_ctx="CustomerLanding_node1768679801018")

# Script generated for node SQL Query
SqlQuery2617 = '''
select * from customer_landing where shareWithResearchAsOfDate is not null;
'''
SQLQuery_node1768680608419 = sparkSqlQuery(glueContext, query = SqlQuery2617, mapping = {"customer_landing":CustomerLanding_node1768679801018}, transformation_ctx = "SQLQuery_node1768680608419")

# Script generated for node Amazon S3
EvaluateDataQuality().process_rows(frame=SQLQuery_node1768680608419, ruleset=DEFAULT_DATA_QUALITY_RULESET, publishing_options={"dataQualityEvaluationContext": "EvaluateDataQuality_node1768681397285", "enableDataQualityResultsPublishing": True}, additional_options={"dataQualityResultsPublishing.strategy": "BEST_EFFORT", "observations.scope": "ALL"})
AmazonS3_node1768681901848 = glueContext.getSink(path="s3://stedi-s3-pa/customer_trusted/", connection_type="s3", updateBehavior="UPDATE_IN_DATABASE", partitionKeys=[], enableUpdateCatalog=True, transformation_ctx="AmazonS3_node1768681901848")
AmazonS3_node1768681901848.setCatalogInfo(catalogDatabase="stedi_s3_pa",catalogTableName="customer_trusted")
AmazonS3_node1768681901848.setFormat("json")
AmazonS3_node1768681901848.writeFrame(SQLQuery_node1768680608419)
job.commit()