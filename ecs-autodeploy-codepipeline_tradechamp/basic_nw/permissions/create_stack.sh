# verify if stack already exists 
cmd="aws cloudformation describe-stacks --stack-name perm --query \"Stacks[0].StackName\" --output  text"
status=$(eval "$cmd" 2>/dev/null)
 if [[ $status == "perm" ]]
    then
       echo "Permission Stack already exists, not creating again... "
       exit 0
 fi


aws cloudformation create-stack --stack-name perm --template-body file://perm.yaml --capabilities CAPABILITY_NAMED_IAM  $*
# Throw error message if there is an issue
 if [[ $? -ne 0 ]]
    then
       echo ".... some issue, exiting "
       exit -1
 fi

aws cloudformation wait stack-create-complete --stack-name perm
# Throw error message if there is an issue
 if [[ $? -ne 0 ]]
    then
       echo ".... some issue, exiting "
       exit -1
 fi

# To pass different environment information 
# ./create_stack.sh --parameters ParameterKey=environment,ParameterValue=prod
