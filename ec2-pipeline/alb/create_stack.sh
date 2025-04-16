aws cloudformation create-stack --stack-name alb --template-body file://alb.yaml $*

aws cloudformation wait stack-create-complete --stack-name alb

# To pass different environment information 
# ./create_stack.sh --parameters ParameterKey=environment,ParameterValue=prod
