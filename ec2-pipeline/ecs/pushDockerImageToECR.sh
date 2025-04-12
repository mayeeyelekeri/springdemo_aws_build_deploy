#!/bin/bash 

echo "inside pushImageto repo script" 
repository_name="springdemo"
region="us-east-1"

## Create the repository 
aws ecr create-repository --repository-name $repository_name
 
# -- Get specific values of the repository and remove quotes (double quotes are there in the beginning and end) 
uri=`aws ecr  describe-repositories --repository-name $repository_name --query repositories[0].repositoryUri`
uri=`echo $uri | tr -d '"'`

arn=`aws ecr  describe-repositories --repository-name $repository_name --query repositories[0].repositoryArn`
arn=`echo $arn | tr -d '"'`

aws_account_id=`aws ecr  describe-repositories --repository-name $repository_name --query repositories[0].registryId` 
aws_account_id=`echo $aws_account_id | tr -d '"'`

echo "URI: $uri"
echo "ARN: $arn" 
echo "AWS Account ID: $aws_account_id"

## login to ECR from command line 
# Syntax: aws ecr get-login-password --region <region> | docker login --username AWS --password-stdin <account_id>.dkr.ecr.<region>.amazonaws.com
cmd="aws ecr get-login-password --region $region | docker login --username AWS --password-stdin $aws_account_id.dkr.ecr.us-east-1.amazonaws.com"
echo "executing cmd: $cmd"
eval output=\`${cmd}\`
echo "output of login: $output"

 
##  -- Tag an ECR image to push 
##  docker tag e9ae3c220b23 <aws_account_id>.dkr.ecr.<region>.amazonaws.com/<repository_name>:tag
docker tag $repository_name $aws_account_id.dkr.ecr.us-east-1.amazonaws.com/$repository_name
 
##  -- Push image to repository 
##  docker push <aws_account_id>.dkr.ecr.<region>.amazonaws.com/<repository>:tag
docker push $aws_account_id.dkr.ecr.us-east-1.amazonaws.com/$repository_name

## Add a new parameter with the repository Path
aws ssm put-parameter \
            --name "/dev/ecs/ecr_repository" \
            --type "String" \
            --value "$uri" \
            --overwrite

## Add a new parameter with the repository arn
aws ssm put-parameter \
            --name "/dev/ecs/ecr_repository_arn" \
            --type "String" \
            --value "$arn" \
            --overwrite
