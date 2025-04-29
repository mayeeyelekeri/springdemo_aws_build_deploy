aws cloudformation create-stack --stack-name utils --capabilities CAPABILITY_NAMED_IAM --template-body file://utils.yaml $*

aws cloudformation wait stack-create-complete --stack-name utils

# To pass different environment information 
# ./create_stack.sh --parameters ParameterKey=environment,ParameterValue=prod
