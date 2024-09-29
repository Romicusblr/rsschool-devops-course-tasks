# Terraform Project Documentation

## Overview
This Terraform project is designed to provision and manage cloud infrastructure resources. The project includes a set of scripts and configurations to automate the deployment and management of these resources.

## Prerequisites
- Terraform installed on your local machine.
- An active account with the cloud provider you intend to use (e.g., AWS, Azure, GCP).
- Properly configured authentication credentials for the cloud provider.

## Project Structure
- `main.tf`: The primary Terraform configuration file where resources are defined.
- `variables.tf`: Defines the input variables for the Terraform configuration.
- `outputs.tf`: Specifies the outputs of the Terraform configuration.
- `provider.tf`: Configures the provider (e.g., AWS, Azure, GCP) for Terraform.
- `Makefile`: Contains commands to simplify the execution of Terraform scripts.

## Running the Scripts from Makefile
The `Makefile` includes several commands to manage the Terraform workflow. Below are the primary commands:

- `make init`: Initializes the Terraform working directory.
- `make plan`: Generates and shows an execution plan.
- `make apply`: Applies the changes required to reach the desired state of the configuration.
- `make destroy`: Destroys the Terraform-managed infrastructure.

### Example Usage
1. **Initialize the Terraform working directory:**
  ```sh
  make init
  ```

2. **Generate and review the execution plan:**
  ```sh
  make plan
  ```

3. **Apply the changes to reach the desired state:**
  ```sh
  make apply
  ```

4. **Destroy the Terraform-managed infrastructure:**
  ```sh
  make destroy
  ```

## Created Resources
This project create and manage cloud resources:
- Storage Bucket
- IAM policy for github workflow with OIDC provider
