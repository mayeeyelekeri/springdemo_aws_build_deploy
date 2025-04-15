#!/bin/bash 

aws cloudformation update-stack --stack-name codepipeline --capabilities CAPABILITY_NAMED_IAM --template-body file://codepipeline.yaml $*

status=$?
if [ $status -eq 0 ]; then
	aws cloudformation wait stack-update-complete --stack-name codepipeline
fi

# To change values to prod, pass the following 
# ./update_stack.sh --parameters ParameterKey=vpcCidr,ParameterValue=/prod/vpc/vpc_cidr
