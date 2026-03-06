Project Overview
The cloud is perfect for hosting static websites that only include HTML, CSS, and JavaScript files that require no server-side processing. The whole project has two major intentions to implement:

Hosting a static website on S3 and
Accessing the cached website pages using CloudFront content delivery network (CDN) service. Recall that CloudFront offers low latency and high transfer speeds during website rendering.
Note that Static website hosting essentially requires a public bucket, whereas the CloudFront can work with public and private buckets.

In this project, you will deploy a static website to AWS by performing the following steps:

You will create a public S3 bucket and upload the website files to your bucket.
You will configure the bucket for website hosting and secure it using IAM policies.
You will speed up content delivery using AWS’s content distribution network service, CloudFront.
You will access your website in a browser using the unique CloudFront endpoint.

Website urls:
https://dstnrteiat4y.cloudfront.net/index.html

http://aryapvy-aws.s3-website.us-east-1.amazonaws.com/

http://aryapvy-aws.s3.amazonaws.com/index.html


NB: Screenshots are taken after all steps have been completed








