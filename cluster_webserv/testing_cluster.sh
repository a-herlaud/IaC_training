#!/bin/bash

set -e

terraform apply

echo "TEST SERVER OUTPUT\n"

terraform output -json public_ips | jq -r '.[]' | while read ip; do
  echo "━━━━━━━━━━━━━━━━━━━━━━━━━"
  echo "Testing: http://$ip:8080"
  echo "-------------------------"
  curl "http://$ip:8080"
  echo ""
done