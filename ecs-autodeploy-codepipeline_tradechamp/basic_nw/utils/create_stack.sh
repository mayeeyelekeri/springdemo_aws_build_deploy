# verify if stack already exists
cmd="aws cloudformation describe-stacks --stack-name utils --query \"Stacks[0].StackName\" --output  text"
status=$(eval "$cmd" 2>/dev/null)
 if [[ $status == "utils" ]]
    then
       echo "Utils Stack already exists, not creating again... "
       exit 0
 fi


aws cloudformation create-stack --stack-name utils --capabilities CAPABILITY_NAMED_IAM --template-body file://utils.yaml $*
# Throw error message if there is an issue
 if [[ $? -ne 0 ]]
    then
       echo ".... some issue, exiting "
       exit -1
 fi

aws cloudformation wait stack-create-complete --stack-name utils
# Throw error message if there is an issue
 if [[ $? -ne 0 ]]
    then
       echo ".... some issue, exiting "
       exit -1
 fi

# To pass different environment information 
# ./create_stack.sh --parameters ParameterKey=environment,ParameterValue=prod
