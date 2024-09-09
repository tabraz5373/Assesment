# Assesment


# Automated Infrastructure Setup using Terraform

# main.tf

terraform init

terraform apply 

#the above main.tf will provision a VPC, subnets, firewall rules, and a web server instance on GCP using Terraform. The web server will be accessible via HTTP/HTTPS.

----------------------------------------------------------------------------------------------------------------------------------------------------------------------
# Jenkins CI/CD Pipeline 

# Pre-requisites:
#Install Jenkins on a server 
#Install the Google Cloud SDK on the Jenkins server to interact with GCP.
#Git Plugin for pulling code from a Git repository.
#Pipeline Plugin for creating Jenkins pipelines.
#SSH Agent Plugin for SSH-based deployments.

#the above Jenkinsfile.groovy will automate the CI/CD pipeline, building, testing, and deploying of sample  Node.js application to a Compute Engine instance using Jenkins.

----------------------------------------------------------------------------------------------------------------------------------------------------------------------
# Set Up Monitoring in Google Cloud Console
1. Access Monitoring
2. Create a Dashboard
3. Navigate to Dashboards in the Monitoring section.
   Click Create Dashboard.
   Add widgets to monitor CPU, memory, and disk usage. For each widget, you can select metrics such as
   compute.googleapis.com/instance/diskio for disk I/O,
   compute.googleapis.com/instance/disk for disk usage, 
   compute.googleapis.com/instance/memory for memory usage,
   compute.googleapis.com/instance/disk for CPU usage.
# Set Up an Alert for High CPU Usage
1. Create an Alert Policy

   In the Monitoring section of the Google Cloud Console, navigate to Alerting.
   Click Create Policy.
2. Add a Condition

   Click Add Condition.
   Choose Metric Absence or Metric Threshold depending on your needs.
   For CPU usage, select Metric Threshold.
   Configure the metric to monitor: compute.googleapis.com/instance/diskio or similar.
   Set the condition for CPU usage exceeding 80%.
3. Set Notification Channels

After configuring the condition, add a notification channel.
Choose Email and provide your email address.
4. Save the Alert Policy

click Save to create the alert policy.

#By following the above steps, we will be able to monitor VM instance’s resource usage and receive email notifications if CPU usage exceeds the specified threshold.


# Thanks. 
