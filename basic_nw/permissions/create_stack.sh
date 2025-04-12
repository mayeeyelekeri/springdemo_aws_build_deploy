aws cloudformation create-stack --stack-name perm --template-body file://perm_with_instance_profile.yaml --capabilities CAPABILITY_NAMED_IAM  $*

aws cloudformation wait stack-create-complete --stack-name perm

# To pass different environment information 
# ./create_stack.sh --parameters ParameterKey=environment,ParameterValue=prod
