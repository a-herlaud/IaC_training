#!/bin/bash

set -e

terraform apply

PUBLIC_IP=$(terraform output -raw public_ip)

echo "TEST SERVER OUTPUT\n"

curl "http://$PUBLIC_IP:8080"