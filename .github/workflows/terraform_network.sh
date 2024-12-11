#!/bin/bash

cd Network
terraform init
terraform plan -out=tfplan_network

# Check if there are destroy actions in the network plan
terraform show -json tfplan_network | jq '.resource_changes[] | select(.change.actions[] | contains("destroy"))' > destroyed_network_resources.json

if [[ -s destroyed_network_resources.json ]]; then
  echo "Network has resources to destroy, applying webserver resources first."
  echo "true" >> $GITHUB_ENV
else
  echo "false" >> $GITHUB_ENV
fi