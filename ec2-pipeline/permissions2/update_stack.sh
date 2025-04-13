#!/bin/bash

aws cloudformation update-stack --stack-name perm2 --template-body file://perm2.yaml   --capabilities CAPABILITY_NAMED_IAM $*

status=$?
if [ $status -eq 0 ]; then
	aws cloudformation wait stack-update-complete --stack-name perm2 
fi

# To change values to prod, pass the following 
# ./update_stack.sh --parameters ParameterKey=vpcCidr,ParameterValue=/prod/vpc/vpc_cidr
