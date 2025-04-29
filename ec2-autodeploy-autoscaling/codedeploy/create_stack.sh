aws cloudformation create-stack --stack-name codedeploy --capabilities CAPABILITY_NAMED_IAM --template-body file://codedeploy.yaml $*

aws cloudformation wait stack-create-complete --stack-name codedeploy

# To pass different environment information 
# ./create_stack.sh --parameters ParameterKey=environment,ParameterValue=prod
