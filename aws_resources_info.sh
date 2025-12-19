#!/bin/bash

# AWS Resource Information Script
# This script fetches information related to Ec2, S3, Vpc & Ebs services

# Checks if the required number of arguments are passed
if [ $# -ne 2 ]; then
    echo "Usage: ./aws_resource_list.sh  <aws_region> <aws_service>"
    echo "Example: ./aws_resource_list.sh us-east-1 ec2"
    exit 1
fi

# Assign the arguments to variables and convert the service to lowercase
aws_region=$(echo "$1" | tr "[:upper:]" "[:lower:]")
aws_service=$(echo "$2" | tr "[:upper:]" "[:lower:]") 

# Dependency check for JQ
 command -v jq >/dev/null 2>&1
if [ $? -ne 0 ]; then
   echo "ERROR: JQ is not installed, please install the JQ"
   exit 1
fi

#Lists resources based on service

case $aws_service in
    ec2)
        echo "Listing EC2 Instances in $aws_region"
        aws ec2 describe-instances --region $aws_region | jq '.Reservations[].Instances[] | "\(.InstanceId)\t\((.Tags[]? | select(.Key=="Name") | .Value) // "NoName")"' -r
        ;;
    s3)
        echo "Listing S3 Buckets in $aws_region"
        aws s3 ls --region $aws_region | cut -d " " -f 3
        ;;
    vpc)
        echo "Listing VPCs in $aws_region"
        aws ec2 describe-vpcs --region $aws_region | jq '.Vpcs[] | "\(.VpcId)\t\(.CidrBlock)"' -r
        ;;
    ebs)
        echo "Listing EBS Volumes in $aws_region" 
        aws ec2 describe-volumes --region $aws_region | jq '.Volumes[] | "\(.VolumeId)\t\(.Size)GiB"' -r
        ;;
    *)
        echo "Invalid service. Please enter a valid service."
        exit 1
        ;;
esac