# verify if stack already exists                                                                                  
cmd="aws cloudformation describe-stacks --stack-name codepipeline --query \"Stacks[0].StackName\" --output  text"          
status=$(eval "$cmd" 2>/dev/null)
 if [[ $status == "codepipeline" ]]                                                                                        
    then                                                                                                          
       echo "codepipeline Stack already exists, not creating again... "                                                    
       exit 0                                                                                                     
 fi  
 
aws cloudformation create-stack --stack-name codepipeline --capabilities CAPABILITY_NAMED_IAM --template-body file://codepipeline_ec2.yaml $*
# Throw error message if there is an issue
 if [[ $? -ne 0 ]]
    then
       echo ".... some issue with codepipeline, exiting "
       exit -1
 fi
 
aws cloudformation wait stack-create-complete --stack-name codepipeline
# Throw error message if there is an issue
 if [[ $? -ne 0 ]]
    then
       echo ".... some issue with codepipeline, exiting "
       exit -1
 fi
 
# To pass different environment information 
# ./create_stack.sh --parameters ParameterKey=environment,ParameterValue=prod
