# verify if stack already exists                                                                                  
cmd="aws cloudformation describe-stacks --stack-name codebuild --query \"Stacks[0].StackName\" --output  text"          
status=$(eval "$cmd" 2>/dev/null)
 if [[ $status == "codebuild" ]]                                                                                        
    then                                                                                                          
       echo "codebuild Stack already exists, not creating again... "                                                    
       exit 0                                                                                                     
 fi                                                                                                               
                                                                                                                  

aws cloudformation create-stack --stack-name codebuild --capabilities CAPABILITY_NAMED_IAM --template-body file://codebuild.yaml $*
# Throw error message if there is an issue
 if [[ $? -ne 0 ]]
    then
       echo ".... some issue, exiting "
       exit -1
 fi

aws cloudformation wait stack-create-complete --stack-name codebuild
# Throw error message if there is an issue
 if [[ $? -ne 0 ]]
    then
       echo ".... some issue, exiting "
       exit -1
 fi

 # Start the build
#projectName=`aws ssm get-parameter --name "/dev/codebuild/tradechamp/project_name"  --with-decryption  --output text --query Parameter.Value`
#aws codebuild start-build --project-name $projectName

# To pass different environment information 
# ./create_stack.sh --parameters ParameterKey=environment,ParameterValue=prod
