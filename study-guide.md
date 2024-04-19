# Study guide - Terraform Associate certification

## Learn about Infrastructure as Code (IaC)

- Infrastructure as Code introduction video
- Introduction to IaC documentation
- Introduction to Infrastructure as Code with Terraform
- Infrastructure as Code in a Private or Public Cloud blog post
- Terraform Use Cases documentation

These resources cover Infrastructure as Code (IaC) concepts and the purpose of Terraform (Objectives #1 and #2).

## Review Terraform fundamentals

Complete the Get Started tutorials to create, modify, and destroy your first infrastructure using Terraform, and to learn about Terraform providers and the basics of Terraform state.

- Get Started with Terraform (complete all tutorials) 

Review the following resources to learn more about Terraform, providers, and state.

- Purpose of Terraform State documentation
- Terraform Settings documentation
- Manage Terraform Versions tutorial
- Providers Summary documentation
- How Terraform Works with Plugins documentation
- Provider Configuration documentation
- Lock and Upgrade Provider Versions tutorial
- Dependency Lock File documentation

These resources cover Terraform basics (Objective #3).

## Navigate the core workflow
The core Terraform workflow consists of writing configuration, initializing a working directory, planning infrastructure changes, and then applying them. The Terraform CLI also offers subcommands to validate and format your configuration as you develop it. Review the following resources to learn about the core Terraform workflow.

The Core Terraform Workflow documentation
Initialize a Terraform working directory with init documentation
Initialize Terraform Configuration tutorial
Validate a Terraform configuration with validate documentation
Command: plan documentation
Create a Terraform Plan tutorial
Command: apply documentation
Apply Terraform Configuration tutorial
Command: destroy documentation
Command: fmt documentation
Troubleshoot Terraform tutorial
These resources cover the core Terraform workflow (Objective #6).

## Learn more subcommands
The Terraform CLI includes subcommands for operations beyond the core workflow, including importing resources and manipulating and inspecting state. Review the following resources and tutorials to get more familiar with the Terraform CLI.

Command: state documentation
Manage Resources in Terraform State tutorial
Command: import documentation
Import usage tips documentation
Debugging Terraform documentation
Troubleshoot Terraform tutorial
These resources cover the Terraform CLI outside of the core workflow (Objective #4).

## Use and create modules
Modules help you organize and re-use Terraform configuration. Complete the Modules tutorials to learn more about modules, including how to reference modules from the Terraform registry and create your own.

Reuse Configuration with Modules (complete all tutorials)
Review these additional resources to learn about modules and associated concepts in more depth.

Finding and Using Modules documentation
Module versioning documentation
Input Variables documentation
Input Variables tutorial
Output Values documentation
Output Values tutorial
Calling a Child Module documentation
These resources cover the fundamentals of Terraform modules (Objective #5).

## Read and write configuration
Terraform configuration uses the HashiCorp Configuration Language (HCL). Review the following resources to learn more about HCL syntax and functions.

Resources documentation
Resource Addressing documentation
References Named Values documentation
Data Sources documentation
Query Data Sources tutorial
Create Resource Dependencies tutorial
Resource Graph documentation
Target Resources tutorial
Complex Types documentation
Built-in Functions documentation
Perform Dynamic Operations with Functions tutorial
Create Dynamic Expressions tutorial
Terraform configuration may require access to sensitive data to provision infrastructure. Review the following resources to learn more about secure secrets injection using Vault.

Inject Secrets into Terraform Using the Vault Provider tutorial
Vault Provider for Terraform documentation
These resources cover the basics of reading, generating, and modifying Terraform configuration (Objective #8).

## Manage state
Terraform uses state to keep track of the infrastructure it manages. To use Terraform effectively, you have to keep your state accurate and secure. Read the following resources to learn about managing Terraform's state and storage backends.

State management:

State Locking documentation
Protect Sensitive Input Variables tutorial
Sensitive Data in State documentation
Refresh-Only Mode documentation
Use Refresh-Only Mode to Sync Terraform State tutorial
Manage Resource Drift tutorial
Manage Resources in Terraform State tutorial
Backend management:

Command: login documentation
Log in to Terraform Cloud from the CLI tutorial
Backends documentation
Local backend documentation
Backend configuration documentation
Terraform Cloud Configuration documentation
Create a Workspace tutorial
Store Remote State tutorial
Migrate State to Terraform Cloud tutorial
These resources cover Terraform state and backends. (Objective #7)

## Understand Terraform Cloud
Terraform Cloud helps teams collaborate on Infrastructure as Code by providing a stable and reliable environment for operations, shared state and secret data, access controls to manage permissions for team members, and a policy framework for governance.

Review the following resources to better understand how Terraform Cloud enables Terraform workflows at scale.

What is Terraform Cloud? documentation
Terraform Cloud Workflow documentation
Terraform Cloud Workspaces documentation
Terraform Cloud Get Started Collection tutorials
Manage Versions in Terraform Cloud tutorial
Use Modules from the Registry tutorial
Private Registry documentation
Terraform Cloud Teams documentation
Manage Permissions in Terraform Cloud tutorial
Sentinel documentation
Enforce a Policy tutorial
These resources cover Terraform Cloud capabilities. (Objective #9)

## Next steps
For a reference of the specific study materials that cover a particular exam objective, refer to the review guide. Check out the sample questions to review the exam question format.