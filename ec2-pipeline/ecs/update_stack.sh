aws cloudformation update-stack --stack-name ecs-part1 --template-body file://ecs-part1.yaml  --capabilities CAPABILITY_NAMED_IAM $*

aws cloudformation update-stack --stack-name ecs-part2 --template-body file://ecs-part2.yaml  --capabilities CAPABILITY_NAMED_IAM $*


# To change values to prod, pass the following 
# ./update_stack.sh --parameters ParameterKey=vpcCidr,ParameterValue=/prod/vpc/vpc_cidr
