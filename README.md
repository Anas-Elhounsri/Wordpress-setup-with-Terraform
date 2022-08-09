# Wordpress setup with Terraform on AWS 

## Overview

In this code we fully automate setting up a wordpress on an EC2 instance with Terraform along with the following services:
- EC2 
- VPC 
- S3 
- LB  
- VPN 
- EIP  
- Route53 
- RDS

## Dependencies
- AWS CLI
- Terraform
- Git
- VS (in my case)

## Features
- RDS and EC2 are not available for public (Private VPC)
- 1 public subnet for EC2 and 2 private subnet for RDS
- Nginx is the webserver
- PostgreSQL is the datbase (For now we will go with MySQL)
- A VPN connection between Wordpresss and RDS
- An S3 bucket 
- Load balancer with a listener
- Private route53 zone
- 1 security group for EC2 and 1 for RDS
- A generated SSH key for terraform to access the EC2

## How the ecosystem works for some services
I made this simple diagram to show how the ecosystem works
### Work Diagram

![This is an image](https://www.upload.ee/image/14337186/work_diagram.drawio__1_.png)

## what's been done so far

All the services have been deployed successfully, for the database I used mySQL, and the website is up running (though when it comes to set up wordpress it was done manually).








