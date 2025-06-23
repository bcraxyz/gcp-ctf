#!/bin/bash

set -e

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd "$SCRIPT_DIR" || exit 1

# Common init
cd common || exit 1
terraform init
terraform apply -auto-approve -var-file=../terraform.tfvars
FOLDER_ID=$(terraform output -raw ctf_folder_id)
cd ..

# If arguments are given, use them as the list of challenges
if [ "$#" -gt 0 ]; then
  CHALLENGES=("$@")
else
  CHALLENGES=(challenges/*)
fi

# Deploy selected or all challenges
for CHALLENGE in "${CHALLENGES[@]}"; do
  if [ -d "$CHALLENGE" ]; then
    echo "[+] Deploying $CHALLENGE..."
    cd "$CHALLENGE" || exit 1

    terraform init
    terraform apply -auto-approve \
      -var-file=../../terraform.tfvars \
      -var="ctf_folder_id=$FOLDER_ID"

    cd - > /dev/null
  else
    echo "[!] Skipping non-directory: $CHALLENGE"
  fi
done
