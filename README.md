# AWS Resource Tracker

## Project Overview

AWS Resource Tracker is a simple DevOps project that collects information about AWS resources and creates a report automatically.

The project uses Bash scripting, AWS CLI, Amazon S3, and cron.

It helps us check which AWS resources exist in our account and save their details in a text report. The report is also uploaded to an S3 bucket for storage.

## Project Goals

* Collect information about AWS resources.
* Generate a report using a Bash script.
* Save reports with date and time in their filenames.
* Upload reports to Amazon S3.
* Automate report generation using cron.

## AWS Services and Tools Used

* **Amazon EC2:** Runs the scripts.
* **AWS CLI:** Communicates with AWS services.
* **Amazon S3:** Stores generated reports.
* **AWS IAM Role:** Gives the EC2 instance permission to access required AWS resources.
* **Linux:** Provides the environment to run the scripts.
* **Bash:** Automates report generation and upload.
* **Cron:** Runs the report script on a schedule.
* **Git and GitHub:** Track and store the project code.

## Features

### 1. AWS Resource Report

The main script collects information about:

* EC2 instances and their states.
* S3 buckets.
* Lambda functions.
* IAM users.
* AWS account ID.

### 2. Automatic Report Generation

The script creates a text report containing the available resource information.

### 3. Amazon S3 Upload

The wrapper script uploads the generated report to the `reports/` folder in the configured S3 bucket.

### 4. Scheduled Automation

Cron can run the wrapper script automatically every day at 7:00 PM, using the EC2 instance's configured local time.

### 5. Logging

The wrapper script records important activities in `run.log`, such as report generation, upload success, and errors.

## Project Structure

```text
aws-resource-tracker/
├── aws_resource_tracker.sh
├── run_aws_report.sh
├── README.md
├── .gitignore
├── run.log
└── reports/
    └── aws_resource_report_<timestamp>.txt
```

**Note:** `run.log` and the `reports/` folder are excluded from Git using `.gitignore`. They are generated or used while the project runs.

## How the Project Works

1. Cron starts the wrapper script at the scheduled time.
2. The wrapper script runs the main Bash script.
3. AWS CLI requests resource information from AWS.
4. The main script generates a text report.
5. The wrapper script uploads the report to Amazon S3.
6. The wrapper script records the result in the log file.

## Setup and Execution

### Step 1: Connect to the EC2 Instance

Connect to your Amazon Linux EC2 instance.

### Step 2: Open the Project Directory

```bash
cd /home/ec2-user/aws-resource-tracker
```

### Step 3: Make the Scripts Executable

```bash
chmod 750 aws_resource_tracker.sh run_aws_report.sh
```

### Step 4: Run the Resource Report

```bash
./aws_resource_tracker.sh
```

This displays the resource information in the terminal.

### Step 5: Generate and Upload a Report

```bash
./run_aws_report.sh
```

This runs the report process, saves a timestamped report, uploads it to S3, and records the activities in the log file.

### Step 6: Check the Log File

```bash
tail -n 20 run.log
```

This displays the latest log entries.

### Step 7: Check Reports in Amazon S3

```bash
aws s3 ls s3://aditi-08/reports/ --region ap-south-1
```

This lists the reports in the configured S3 folder, provided the IAM role has the required permissions.

## Cron Automation

To run the wrapper script every day at 7:00 PM, add this cron entry:

```cron
0 19 * * * /home/ec2-user/aws-resource-tracker/run_aws_report.sh
```

Make sure the cron service is running and the EC2 instance's timezone is correct.

## IAM Permissions

The EC2 instance uses an IAM role to access AWS services without storing AWS access keys inside the scripts.

The role needs suitable permissions to:

* Describe EC2 instances.
* List Lambda functions.
* List IAM users.
* List S3 buckets.
* Upload reports to the configured S3 bucket.
* List objects in the report bucket when required.

Follow the principle of least privilege: grant only the permissions the project needs.

## Security Practices

* Do not upload AWS access keys, passwords, private keys, or tokens to GitHub.
* Keep generated reports and logs out of the Git repository.
* Use an IAM role instead of hardcoding AWS credentials.
* Grant only the required IAM permissions.
* Keep sensitive account and resource information private when sharing project output.

## Limitations

This project creates an inventory report of selected AWS resources. It does not currently provide live CPU or memory monitoring, CloudWatch alarms, or automatic alerts.

## Future Improvements

* Add AWS CloudWatch metrics.
* Send reports by email.
* Add error notifications.
* Improve report formatting with CSV output.
* Add automated testing and a CI/CD pipeline.

## What I Learned

Through this project, I practised:

* Writing Bash scripts.
* Using AWS CLI commands.
* Working with EC2 and IAM roles.
* Uploading files to Amazon S3.
* Automating tasks using cron.
* Checking logs and troubleshooting errors.
* Managing project code using Git and GitHub.

## Repository

GitHub: https://github.com/Aditi-Paliwal5/Aws-Resource-Tracker

---

**Project:** AWS Resource Tracker
**Purpose:** AWS resource inventory and automated report storage
**Environment:** Amazon Linux EC2, AWS CLI, Bash, Amazon S3, cron
