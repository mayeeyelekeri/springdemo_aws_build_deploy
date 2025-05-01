aws cloudformation create-stack --stack-name beanstalk --capabilities CAPABILITY_NAMED_IAM --template-body file://beanstalk.yaml $*

aws cloudformation wait stack-create-complete --stack-name beanstalk

# To pass different environment information 
# ./create_stack.sh --parameters ParameterKey=environment,ParameterValue=prod
