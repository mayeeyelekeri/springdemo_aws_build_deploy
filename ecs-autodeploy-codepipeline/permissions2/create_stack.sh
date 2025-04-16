aws cloudformation create-stack --stack-name perm2 --template-body file://perm2.yaml --capabilities CAPABILITY_NAMED_IAM  $*

aws cloudformation wait stack-create-complete --stack-name perm2

# To pass different environment information 
# ./create_stack.sh --parameters ParameterKey=environment,ParameterValue=prod
