# verify if stack already exists                                                                                  
cmd="aws cloudformation describe-stacks --stack-name lambda --query \"Stacks[0].StackName\" --output  text"          
status=$(eval "$cmd" 2>/dev/null)
 if [[ $status == "lambda" ]]                                                                                        
    then                                                                                                          
       echo "lambda Stack already exists, not creating again... "                                                    
       exit 0                                                                                                     
 fi  
 
# Make sure "codebuild" is called before this 
# Upload all zip files 
./init2.sh 
 if [[ $? -ne 0 ]]
    then
       echo ".... some issue with executing init2.sh file, exiting "
       exit -1
 fi
  
aws cloudformation create-stack --stack-name lambda --capabilities CAPABILITY_NAMED_IAM --template-body file://lambda.yaml $*
# Throw error message if there is an issue
 if [[ $? -ne 0 ]]
    then
       echo ".... some issue with lambda, exiting "
       exit -1
 fi
 
aws cloudformation wait stack-create-complete --stack-name lambda
# Throw error message if there is an issue
 if [[ $? -ne 0 ]]
    then
       echo ".... some issue with lambda, exiting "
       exit -1
 fi
#./invoke_lambda.sh 

# To pass different environment information 
# ./create_stack.sh --parameters ParameterKey=environment,ParameterValue=prod
