#!/bin/bash

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd "$SCRIPT_DIR" || exit 1

# Common init
cd common || exit 1
terraform init
terraform apply -auto-approve -var-file=../terraform.tfvars
FOLDER_ID=$(terraform output -raw ctf_folder_id)
cd ..

# Deploy challenge(s)
for CHALLENGE in challenges/*; do
  if [ -d "$CHALLENGE" ]; then
    echo "[+] Deploying $CHALLENGE..."
    cd "$CHALLENGE" || exit 1

    terraform init
    terraform apply -auto-approve \
      -var-file=../../terraform.tfvars \
      -var="ctf_folder_id=$FOLDER_ID"

    cd - > /dev/null
  fi
done
