# verify if stack already exists                                                                                  
cmd="aws cloudformation describe-stacks --stack-name autoscale --query \"Stacks[0].StackName\" --output  text"          
status=$(eval "$cmd" 2>/dev/null)
 if [[ $status == "autoscale" ]]                                                                                        
    then                                                                                                          
       echo "autoscale Stack already exists, not creating again... "                                                    
       exit 0                                                                                                     
 fi   
 
aws cloudformation create-stack --stack-name autoscale --capabilities CAPABILITY_NAMED_IAM --template-body file://autoscale.yaml $*
# Throw error message if there is an issue
 if [[ $? -ne 0 ]]
    then
       echo ".... some issue with autoscaling, exiting "
       exit -1
 fi
 
aws cloudformation wait stack-create-complete --stack-name autoscale
# Throw error message if there is an issue
 if [[ $? -ne 0 ]]
    then
       echo ".... some issue with autoscaling, exiting "
       exit -1
 fi
 
# To pass different environment information 
# ./create_stack.sh --parameters ParameterKey=environment,ParameterValue=prod
