#!/bin/bash 

aws cloudformation update-stack --stack-name codebuild --capabilities CAPABILITY_NAMED_IAM --template-body file://codebuild.yaml $*

status=$?
if [ $status -eq 0 ]; then
	aws cloudformation wait stack-update-complete --stack-name codebuild
fi

# Start the build 
#projectName=`aws ssm get-parameter --name "/dev/codebuild/tradechamp/project_name"  --with-decryption  --output text --query Parameter.Value`
#aws codebuild start-build --project-name $projectName 

# To change values to prod, pass the following 
# ./update_stack.sh --parameters ParameterKey=vpcCidr,ParameterValue=/prod/vpc/vpc_cidr
