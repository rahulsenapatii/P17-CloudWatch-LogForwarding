# Project 17: Log Forwarding to CloudWatch

Configures an Amazon Linux 2023 EC2 instance in `ap-south-1` with an IAM instance profile (`CloudWatchAgentServerPolicy`) and `amazon-cloudwatch-agent` to stream Nginx access logs, error logs, and `/var/log/messages` into Amazon CloudWatch Logs (`/rahul-senapati/p17-web-logs`).
