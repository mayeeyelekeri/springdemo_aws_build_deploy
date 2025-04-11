SECONDS=0
aws cloudformation create-stack --stack-name ec2 --template-body file://ec2-init.yaml  --capabilities CAPABILITY_NAMED_IAM $*

aws cloudformation wait stack-create-complete --stack-name ec2

# To pass different environment information 
# ./create_stack.sh --parameters ParameterKey=environment,ParameterValue=prod
echo "Elapsed Time to create EC2 stack: (using \$SECONDS): $SECONDS  seconds"
