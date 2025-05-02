# verify if stack already exists                                                                                  
cmd="aws cloudformation describe-stacks --stack-name alb --query \"Stacks[0].StackName\" --output  text"          
status=$(eval "$cmd" 2>/dev/null)
 if [[ $status == "alb" ]]                                                                                        
    then                                                                                                          
       echo "alb Stack already exists, not creating again... "                                                    
       exit 0                                                                                                     
 fi                                                                                                               
       
       
aws cloudformation create-stack --stack-name alb --template-body file://alb.yaml $*
# Throw error message if there is an issue
 if [[ $? -ne 0 ]]
    then
       echo ".... some issue with alb, exiting "
       exit -1
 fi

aws cloudformation wait stack-create-complete --stack-name alb
# Throw error message if there is an issue
 if [[ $? -ne 0 ]]
    then
       echo ".... some issue with alb wait, exiting "
       exit -1
 fi

# To pass different environment information 
# ./create_stack.sh --parameters ParameterKey=environment,ParameterValue=prod
