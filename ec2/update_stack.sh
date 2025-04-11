aws cloudformation update-stack --stack-name ec2 --template-body file://ec2-init.yaml  --capabilities CAPABILITY_NAMED_IAM $*

# To change values to prod, pass the following 
# ./update_stack.sh --parameters ParameterKey=vpcCidr,ParameterValue=/prod/vpc/vpc_cidr
