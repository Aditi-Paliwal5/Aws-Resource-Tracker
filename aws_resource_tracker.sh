#!/bin/bash

set -euo pipefail
export AWS_PAGER=""

REGION="ap-south-1"

echo "=========================================="
echo "          AWS RESOURCE REPORT"
echo "=========================================="

echo "Generated at: $(date)"
echo "AWS Region: $REGION"

echo
echo "========== AWS ACCOUNT =========="
aws sts get-caller-identity --query Account --output text

echo
echo "========== EC2 INSTANCES =========="
aws ec2 describe-instances \
  --region "$REGION" \
  --query 'Reservations[].Instances[].[InstanceId,State.Name,InstanceType]' \
  --output table

echo
echo "========== S3 BUCKETS =========="
aws s3 ls

echo
echo "========== LAMBDA FUNCTIONS =========="
aws lambda list-functions \
  --region "$REGION" \
  --query 'Functions[].[FunctionName,Runtime,LastModified]' \
  --output table

echo
echo "========== IAM USERS =========="
aws iam list-users \
  --query 'Users[].[UserName,CreateDate]' \
  --output table

echo
echo "========== REPORT COMPLETED =========="
