#!/bin/bash

# === Configurable vars ===
TF_DIR=~/terraform_c01
TFVARS_FILE=$TF_DIR/terraform.tfvars

# === Input values ===
cat > $TFVARS_FILE <<EOF
project_a = "c01-proj-a"
project_b = "c01-proj-b"
region = "asia-southeast1"
zone  = "asia-southeast1-a"
org_id = "123456789012"
billing_account_id = "ABCDEF-123456-7890AB"
ctf_users_group = "ctf-users@yourdomain.com"
EOF

# === Initialize ===
cd $TF_DIR || exit 1
echo "[+] Initializing Terraform..."
terraform init

# === Validate ===
echo "[+] Validating config..."
terraform validate

# === Plan ===
echo "[+] Running plan..."
terraform plan -var-file=terraform.tfvars

# === Apply ===
echo "[+] Applying configuration..."
terraform apply -auto-approve -var-file=terraform.tfvars
