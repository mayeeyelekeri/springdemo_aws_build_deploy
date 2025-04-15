#!/bin/bash 

# just call the script which takes care of creating parameters 
. ~/INFO/secrets/codedeploy_params.sh  $1
 
# Create a lambda function to perform validation test of application 
aws lambda create-function --function-name AfterAllowTestTraffic        --zip-file fileb://AfterAllowTestTraffic.zip        --handler AfterAllowTestTraffic.handler
--runtime nodejs22.x        --role arn:aws:iam::471112955271:role/lambda-cli-hook-role

# Create Role 
aws iam create-role --role-name lambda-cli-hook-role --assume-role-policy-document file://lambda_role.json

# Create policy 
aws iam create-policy --policy-name AWSLambdaBasicExecutionRole --policy-document file://lambda_policy.json

# Attach policy to role 
aws iam attach-role-policy --policy-arn arn:aws:iam::381492236493:policy/AWSLambdaBasicExecutionRole --role-name lambda-cli-hook-role
