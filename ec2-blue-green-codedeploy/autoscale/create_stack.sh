aws cloudformation create-stack --stack-name autoscale --capabilities CAPABILITY_NAMED_IAM --template-body file://autoscale.yaml $*

aws cloudformation wait stack-create-complete --stack-name autoscale

# To pass different environment information 
# ./create_stack.sh --parameters ParameterKey=environment,ParameterValue=prod
