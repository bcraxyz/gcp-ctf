#!/bin/bash

set -e

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd "$SCRIPT_DIR" || exit 1

# Destroy challenges in reverse order (optional but safer)
for CHALLENGE in $(ls -d challenges/* | sort -r); do
  if [ -d "$CHALLENGE" ]; then
    echo "[+] Destroying $CHALLENGE..."
    cd "$CHALLENGE" || exit 1

    terraform destroy -auto-approve -var-file=../../terraform.tfvars || true

    cd - > /dev/null
  fi
done

# Destroy common
cd common || exit 1
terraform destroy -auto-approve -var-file=../terraform.tfvars
