# DevOps Capstone

DevOps is a set of practices that aim to improve collaboration between development and operations teams. DevOps can reduce the time needed to release updates, using automation to build, test and deploy code. Infrastructure as code is used to create infrastructure that is consistent and repeatable, allowing developers to test their code in production-like environments. Security tools can be incorporated earlier in the development process to find vulnerabilities earlier. These are just some of the benefits of DevOps practices.

## Overview

This project is focused on implementing DevOps practices into the development of a web application, here is an overview of the features implemented:

- Docker image based on httpd, with a homepage giving a brief overview of the project
- GitHub action to deploy the developement environment, triggers when code is changed:
  - Build the Docker image
  - Scan the image for vulnerabilities with Trivy
  - Push the image to Docker Hub
  - Create and update the development environment on AWS with Terraform
- GitHub action to deploy the production environment, manually triggered:
  - Pull the latest development image and tag it as production
  - Push the image to Docker Hub
  - Create and update the production environment on AWS with Terraform
- GitHub action that scans the repository for secrets on a schedule
- GitHub action that destroys the development and production environment

## Secrets and Variables

This project requires the following secrets and variables to be configured for actions to run properly:

Secrets
- AWS_ROLE: Name of the IAM role that will be assumed by Terraform
- AWS_BUCKET_NAME: Name of the S3 bucket stores the Terraform state files
- AWS_BUCKET_DEV_TFSTATES: Name of Terraform state file for the development environment
- AWS_BUCKET_PROD_TFSTATES: Name of Terraform state file for the production environment
- DOCKER_PASSWORD: Password for Docker Hub
- DEV_CIDR_IPV4: CIDR ranges allowed to access the development environment
- PROD_CIDR_IPV4: CIDR ranges allowed to access the production environment

Variables
- AWS_REGION: AWS region to deploy resources in