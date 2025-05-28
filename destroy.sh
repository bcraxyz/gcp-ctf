#!/bin/bash

TF_DIR=~/terraform_c01

cd $TF_DIR || exit 1
echo "[!] Destroying Terraform-managed resources..."
terraform destroy -auto-approve -var-file=terraform.tfvars
