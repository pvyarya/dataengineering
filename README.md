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

NB: Screenshots are taken after all steps have been completed

Steps:

First, you will create an S3 bucket, configure the bucket for website hosting, and secure it using IAM policies.

<img width="1588" height="131" alt="image" src="https://github.com/user-attachments/assets/e3bc7973-603e-4197-af1e-f93fbec21ade" />

<img width="1576" height="412" alt="image" src="https://github.com/user-attachments/assets/82e08771-c50c-409b-a70a-1df5df9dd064" />

<img width="712" height="529" alt="image" src="https://github.com/user-attachments/assets/acdd6008-5382-4739-ae9c-7e5268044d4c" />


All website files should be added to the S3 bucket.
<img width="1895" height="607" alt="image" src="https://github.com/user-attachments/assets/10dfe8a1-fcbc-48b4-b276-1540aaccca40" />


Next, you will upload the website files to your bucket and speed up content delivery using AWS’s content distribution network service, CloudFront.
<img width="1585" height="599" alt="image" src="https://github.com/user-attachments/assets/f10d4c74-84fd-48e5-9f26-9b5bf1b58f98" />






