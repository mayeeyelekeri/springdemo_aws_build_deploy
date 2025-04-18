#!/bin/bash 

# just call the script which takes care of creating parameters 
. ~/INFO/secrets/codedeploy_params.sh  $1
 
iam_role_name="lambda-cli-hook-role2"
iam_policy_name="myLambdaExecutionRole2"

account_id=`aws sts get-caller-identity --query Account --output text`
echo account id = $account_id 

# Create Role 
aws iam create-role --role-name $iam_role_name --assume-role-policy-document file://lambda_role.json
lambda_role_arn=`aws iam get-role --role-name $iam_role_name --query "Role.Arn"`
lambda_role_arn=$(echo "$lambda_role_arn" | tr -d '"')
echo "role = $lambda_role_arn" 
 
# Create policy 
cmd="aws iam create-policy --policy-name $iam_policy_name --policy-document file://lambda_policy.json"
echo "cmd: $cmd" 
$cmd
lambda_policy_arn="arn:aws:iam::$account_id:policy/$iam_policy_name"
echo "policy = $lambda_policy_arn" 

# Attach policy to role 
cmd="aws iam attach-role-policy --policy-arn $lambda_policy_arn --role-name $iam_role_name"
echo "cmd: $cmd" 
$cmd

# Create a lambda function to perform validation test of application 
cmd="aws lambda create-function --function-name BeforeInstall \
        --zip-file fileb://lambdacode/BeforeInstall.zip \
        --handler BeforeInstall.handler \
        --runtime nodejs16.x \
        --role $lambda_role_arn"
echo "cmd: $cmd" 
$cmd

# Create a lambda function to perform validation test of application 
cmd="aws lambda create-function --function-name AfterInstall \
        --zip-file fileb://lambdacode/AfterInstall.zip \
        --handler AfterInstall.handler \
        --runtime nodejs16.x \
        --role $lambda_role_arn"
echo "cmd: $cmd" 
$cmd

# Create a lambda function to perform validation test of application 
cmd="aws lambda create-function --function-name AfterAllowTestTraffic \
        --zip-file fileb://lambdacode/AfterAllowTestTraffic.zip \
        --handler AfterAllowTestTraffic.handler \
        --runtime nodejs16.x \
        --role $lambda_role_arn"
echo "cmd: $cmd" 
$cmd

# Create a lambda function to perform validation test of application 
cmd="aws lambda create-function --function-name BeforeAllowTraffic \
        --zip-file fileb://lambdacode/BeforeAllowTraffic.zip \
        --handler BeforeAllowTraffic.handler \
        --runtime nodejs16.x \
        --role $lambda_role_arn"
echo "cmd: $cmd" 
$cmd

# Create a lambda function to perform validation test of application 
cmd="aws lambda create-function --function-name AfterAllowTraffic \
        --zip-file fileb://lambdacode/AfterAllowTraffic.zip \
        --handler AfterAllowTraffic.handler \
        --runtime nodejs16.x \
        --role $lambda_role_arn"
echo "cmd: $cmd" 
$cmd

# list ARN of Lambda function 
function_arn=`aws lambda get-function --function-name AfterAllowTestTraffic --query "Configuration.FunctionArn"`
echo "function: $function_arn"

# Add additional parameters 
aws ssm put-parameter \
            --name "/dev/codedeploy/function_arn" \
            --type "String" \
            --value $function_arn \
            --overwrite

aws ssm put-parameter \
            --name "/dev/codedeploy/lambda_role_arn" \
            --type "String" \
            --value $lambda_role_arn \
            --overwrite

