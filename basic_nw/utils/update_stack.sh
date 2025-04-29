#!/bin/bash 

aws cloudformation update-stack --stack-name utils --capabilities CAPABILITY_NAMED_IAM --template-body file://utils.yaml $*

status=$?
if [ $status -eq 0 ]; then
	aws cloudformation wait stack-update-complete --stack-name utils
fi

# To change values to prod, pass the following 
# ./update_stack.sh --parameters ParameterKey=vpcCidr,ParameterValue=/prod/vpc/vpc_cidr
