#!/bin/bash

cd Webserver
terraform init
terraform plan -out=tfplan_webserver

if [[ "$GITHUB_ENV" == "true" ]]; then
  terraform apply -auto-approve tfplan_webserver
fi

cd ..
terraform apply -auto-approve tfplan_network