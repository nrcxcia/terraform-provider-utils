#!/bin/bash
set -ex
rm -rf terraform.tfstate terraform.tfstate.backup
terraform apply
output="$(terraform output output)"
expected=$(cat <<EOF
hi hello

  1: 0
  2: 1
  3: 2
  4: 3
  5: 4
EOF)
if [ "$output" != "$expected" ];then
    exit 1
fi
