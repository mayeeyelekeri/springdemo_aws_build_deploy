aws cloudformation create-stack --stack-name lambda --capabilities CAPABILITY_NAMED_IAM --template-body file://lambda.yaml $*

aws cloudformation wait stack-create-complete --stack-name lambda

./invoke_lambda.sh 

# To pass different environment information 
# ./create_stack.sh --parameters ParameterKey=environment,ParameterValue=prod
