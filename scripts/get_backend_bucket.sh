#! /bin/bash

bucket=$(terraform output --state tfstate_backend/terraform.tfstate backend_bucket_name)

echo "bucket = $bucket" > backend_config.tf