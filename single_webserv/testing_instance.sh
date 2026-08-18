#!/bin/bash

set -e

terraform apply

PUBLIC_IP=$(terraform output -raw public_ip)

echo "TEST SERVER OUTPUT\n"

echo "━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "Testing: http://$PUBLIC_IP:8080"
echo "-------------------------"
curl "http://$PUBLIC_IP:8080"
echo ""