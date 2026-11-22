#!/bin/bash
dnf install -y nginx amazon-cloudwatch-agent
systemctl enable --now nginx
echo "<h1>Project 17: CloudWatch Log Forwarding - Rahul Senapati</h1>" > /usr/share/nginx/html/index.html

cat << 'CWCFG' > /opt/aws/amazon-cloudwatch-agent/etc/amazon-cloudwatch-agent.json
{
  "logs": {
    "logs_collected": {
      "files": {
        "collect_list": [
          {
            "file_path": "/var/log/nginx/access.log",
            "log_group_name": "/rahul-senapati/p17-web-logs",
            "log_stream_name": "{instance_id}-nginx-access"
          },
          {
            "file_path": "/var/log/nginx/error.log",
            "log_group_name": "/rahul-senapati/p17-web-logs",
            "log_stream_name": "{instance_id}-nginx-error"
          },
          {
            "file_path": "/var/log/messages",
            "log_group_name": "/rahul-senapati/p17-web-logs",
            "log_stream_name": "{instance_id}-system-messages"
          }
        ]
      }
    }
  }
}
CWCFG

/opt/aws/amazon-cloudwatch-agent/bin/amazon-cloudwatch-agent-ctl \
  -a fetch-config \
  -m ec2 \
  -s \
  -c file:/opt/aws/amazon-cloudwatch-agent/etc/amazon-cloudwatch-agent.json

# Generate initial traffic so log events appear immediately in CloudWatch
for i in {1..10}; do
  curl -s http://localhost/ > /dev/null
  curl -s http://localhost/p17-test-path-$i > /dev/null
done
