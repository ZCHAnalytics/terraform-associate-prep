
<p align="left">
   <img src="https://img.shields.io/badge/License-MIT-yellow.svg?style=plastic&logoColor=white" alt="license">
	<img src="https://img.shields.io/github/last-commit/ZCHAnalytics/terraform-aws?style=plastic&color=0080ff" alt="last-commit">
	<img src="https://img.shields.io/github/languages/top/ZCHAnalytics/terraform-aws?style=plastic&color=0080ff" alt="repo-top-language">
	<img src="https://img.shields.io/github/languages/count/ZCHAnalytics/terraform-aws?style=plastic&color=0080ff" alt="repo-language-count">
  
<p>
<p align="left">
		<em>Developed with the tools below.</em>
</p>
<p align="left">
	<img src="https://img.shields.io/badge/terraform-%235835CC.svg?style=plastic&logo=terraform&logoColor=white" alt="Terraform">
</p>
<hr>


# 🔗 Content - the project documentation is in progress...

# Basic Configuration Files with Codes and Visuals
 - sample code for initialising a docker NGINX engine
 - sample code for initialising an instance on Amazon Web Services 
 - sample code for changing Ubuntu image in the infrastructure 
 - sample code for defining outputs
 - sample code for defining variables
 - sample code for remote state configuration in Terraform Cloud Workspace 

# Basics of Workflow with Terraform CLI with Visuals
- sample codes
- sample command for temporarily changing variables in CLI

# Basics of Workflow with Version Control System - GitHub
- update the remote repository endpoint 
- remove or comment out the `cloud` configuration block in `terraform.tf` 
- enable integration between Terraform Workspace and Github Repository
- pass variable to Workspace with `auto.tfvars` file 
- use a new branch for changes, push changes to new branch, create pull request, merge.
- queue and apply "destroy plan" to release resources
  

# Deploy a web app on AWS

## 0. Credentials
- Create AWS IAM user with necessary access policies
- Generate AWS access keys for Third Party Service
- Add access keys and local IP address as sensitive environment variables in Terraform Workspace

## 1. Web Traffic Security Rules

- create VPC
- create security group
- create web traffic rules
- add security group to instance definition block

## 3. Autoscaling
- terrafrom-aws-vpc module 

## 2. Terrafrom Runs

- Initiate Terrafrom Plan and Apply
- Check the deployment of a Tomcat web server

