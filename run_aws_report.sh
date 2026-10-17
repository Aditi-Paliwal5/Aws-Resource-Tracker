#!/bin/bash

set -euo pipefail

PROJECT_DIR="/home/ec2-user/aws-resource-tracker"
REPORT_DIR="$PROJECT_DIR/reports"
BUCKET="aditi-08"
REGION="ap-south-1"
LOG="$PROJECT_DIR/run.log"

mkdir -p "$REPORT_DIR"

TIMESTAMP=$(date '+%Y-%m-%d_%H-%M-%S')
REPORT="$REPORT_DIR/aws_resource_report_${TIMESTAMP}.txt"

echo "[$(date)] Starting report" >> "$LOG"

if "$PROJECT_DIR/aws_resource_tracker.sh" > "$REPORT" 2>&1; then
    echo "[$(date)] Report generated: $REPORT" >> "$LOG"
else
    echo "[$(date)] Report generation failed: $REPORT" >> "$LOG"
    exit 1
fi

if aws s3 cp "$REPORT" \
    "s3://$BUCKET/reports/$(basename "$REPORT")" \
    --region "$REGION" >> "$LOG" 2>&1; then
    echo "[$(date)] S3 upload successful" >> "$LOG"
else
    echo "[$(date)] S3 upload failed" >> "$LOG"
    exit 1
fi

echo "[$(date)] Report process completed" >> "$LOG"
