aws cloudformation create-stack --stack-name codepipeline --capabilities CAPABILITY_NAMED_IAM --template-body file://codepipeline.yaml $*

aws cloudformation wait stack-create-complete --stack-name codepipeline

# To pass different environment information 
# ./create_stack.sh --parameters ParameterKey=environment,ParameterValue=prod
