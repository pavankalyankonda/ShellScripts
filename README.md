
# AWS Resource Info Script

Shell script to list some AWS resources in a given region. Supports **EC2, S3, VPC, and EBS**.

## Prerequisites

* **AWS CLI** installed and configured (`aws configure`)
* **JQ** installed (used to parse JSON)

Install JQ if missing:

* Ubuntu/Debian:

```bash
sudo apt-get install jq -y
```

## Usage

```bash
./aws_resource_list.sh <aws_region> <aws_service>
```

**Examples:**

```bash
./aws_resource_list.sh us-east-1 ec2
./aws_resource_list.sh us-east-1 s3
./aws_resource_list.sh us-east-1 vpc
./aws_resource_list.sh us-east-1 ebs
```

* `<aws_region>` → AWS region (e.g., `us-east-1`)
* `<aws_service>` → Service name (`ec2`, `s3`, `vpc`, `ebs`)
* Service names are **case-insensitive**


## What it shows

* **EC2** → Instance IDs + Name tag (or "NoName")
* **S3** → Bucket names
* **VPC** → VPC IDs + CIDR blocks
* **EBS** → Volume IDs + size (GiB)

