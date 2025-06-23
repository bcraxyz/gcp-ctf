#!/bin/bash

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd "$SCRIPT_DIR" || exit 1

for CHALLENGE in challenges/challenge01; do
  echo "[!] Destroying $CHALLENGE..."
  cd $CHALLENGE || exit 1

  terraform destroy -auto-approve -var-file=../../terraform.tfvars

  cd - > /dev/null
done

cd common || exit 1
terraform destroy -auto-approve -var-file=../terraform.tfvars
