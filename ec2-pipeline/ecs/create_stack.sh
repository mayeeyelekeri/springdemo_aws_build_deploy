SECONDS=0
aws cloudformation create-stack --stack-name ecs-part1 --template-body file://ecs-part1.yaml  --capabilities CAPABILITY_NAMED_IAM $*

aws cloudformation wait stack-create-complete --stack-name ecs-part1

aws cloudformation create-stack --stack-name ecs-part2 --template-body file://ecs-part2.yaml  --capabilities CAPABILITY_NAMED_IAM $*

aws cloudformation wait stack-create-complete --stack-name ecs-part2

# To pass different environment information 
# ./create_stack.sh --parameters ParameterKey=environment,ParameterValue=prod
echo "Elapsed Time to create EC2 stack: (using \$SECONDS): $SECONDS  seconds"
