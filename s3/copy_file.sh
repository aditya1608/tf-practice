#!/bin/bash

export AWS_ACCESS_KEY_ID=YOUR_ACCESS_KEY_ID
export AWS_SECRET_ACCESS_KEY=YOUR_SECRET_ACCESS_KEY 1 

source_bucket="tf-bucket-1234"
destination_bucket="tf-bucket-4321"

source_file="copy_file.sh"
destination_file="copy_file.sh"

aws s3 cp s3://$source_bucket/$source_file s3://$destination_bucket/$destination_file