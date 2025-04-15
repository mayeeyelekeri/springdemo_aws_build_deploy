#!/bin/bash 

sudo yum update -y 

sudo yum install ruby wget  docker -y 

sudo wget https://aws-codedeploy-us-east-1.s3.us-east-1.amazonaws.com/latest/install

sudo chmod +x ./install

sudo ./install auto 

sudo systemctl start codedeploy-agent 
sudo systemctl status codedeploy-agent 

# Codedeploy agent log location 
# /var/log/aws/codedeploy-agent/codedeploy-agent.log
# https://docs.docker.com/engine/install/linux-postinstall/

sudo usermod -aG docker ec2-user

sudo systemctl start docker



