# verify if stack already exists                                                                                  
cmd="aws cloudformation describe-stacks --stack-name perm2 --query \"Stacks[0].StackName\" --output  text"          
status=$(eval "$cmd" 2>/dev/null)
 if [[ $status == "perm2" ]]                                                                                        
    then                                                                                                          
       echo "perm2 Stack already exists, not creating again... "                                                    
       exit 0                                                                                                     
 fi  
 
aws cloudformation create-stack --stack-name perm2 --template-body file://perm2.yaml --capabilities CAPABILITY_NAMED_IAM  $*
# Throw error message if there is an issue
 if [[ $? -ne 0 ]]
    then
       echo ".... some issue with perm2, exiting "
       exit -1
 fi
 
aws cloudformation wait stack-create-complete --stack-name perm2
# Throw error message if there is an issue
 if [[ $? -ne 0 ]]
    then
       echo ".... some issue with perm2, exiting "
       exit -1
 fi
 
# To pass different environment information 
# ./create_stack.sh --parameters ParameterKey=environment,ParameterValue=prod
