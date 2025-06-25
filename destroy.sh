#!/bin/bash

set -euo pipefail

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd "$SCRIPT_DIR"

# Get folder ID from common terraform state (if it exists)
FOLDER_ID=""
if [ -f "common/terraform.tfstate" ]; then
  cd common
  if terraform output ctf_folder_id &>/dev/null; then
    FOLDER_ID=$(terraform output -raw ctf_folder_id)
  fi
  cd ..
fi

# Destroy all challenges
for CHALLENGE in challenges/*; do
  if [ -d "$CHALLENGE" ]; then
    echo "[!] Destroying $CHALLENGE..."
    cd "$CHALLENGE"
    if [ -n "$FOLDER_ID" ]; then
      terraform destroy -auto-approve \
        -var-file=../../terraform.tfvars \
        -var="ctf_folder_id=$FOLDER_ID" || true
    else
      terraform destroy -auto-approve \
        -var-file=../../terraform.tfvars || true
    fi
    cd - > /dev/null
  fi
done

# Destroy common infra
cd common
terraform destroy -auto-approve -var-file=../terraform.tfvars
