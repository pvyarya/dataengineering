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

# Script generated for node Accelerometer trusted
Accelerometertrusted_node1768746083482 = glueContext.create_dynamic_frame.from_catalog(database="stedi_s3_pa", table_name="accelerometer_trusted", transformation_ctx="Accelerometertrusted_node1768746083482")

# Script generated for node Customer trusted
Customertrusted_node1768746085730 = glueContext.create_dynamic_frame.from_catalog(database="stedi_s3_pa", table_name="customer_trusted", transformation_ctx="Customertrusted_node1768746085730")

# Script generated for node SQL Query
SqlQuery3236 = '''
SELECT DISTINCT c.*
FROM accelerometer_trusted as a
INNER JOIN customer_trusted as c
ON a.user = c.email
'''
SQLQuery_node1768746093820 = sparkSqlQuery(glueContext, query = SqlQuery3236, mapping = {"accelerometer_trusted":Accelerometertrusted_node1768746083482, "customer_trusted":Customertrusted_node1768746085730}, transformation_ctx = "SQLQuery_node1768746093820")

# Script generated for node Amazon S3
EvaluateDataQuality().process_rows(frame=SQLQuery_node1768746093820, ruleset=DEFAULT_DATA_QUALITY_RULESET, publishing_options={"dataQualityEvaluationContext": "EvaluateDataQuality_node1768744042102", "enableDataQualityResultsPublishing": True}, additional_options={"dataQualityResultsPublishing.strategy": "BEST_EFFORT", "observations.scope": "ALL"})
AmazonS3_node1768746491263 = glueContext.getSink(path="s3://stedi-s3-pa/customers_curated/", connection_type="s3", updateBehavior="UPDATE_IN_DATABASE", partitionKeys=[], enableUpdateCatalog=True, transformation_ctx="AmazonS3_node1768746491263")
AmazonS3_node1768746491263.setCatalogInfo(catalogDatabase="stedi_s3_pa",catalogTableName="customers_curated")
AmazonS3_node1768746491263.setFormat("json")
AmazonS3_node1768746491263.writeFrame(SQLQuery_node1768746093820)
job.commit()