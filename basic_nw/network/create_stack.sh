#!/bin/bash 

params="" 

# if "prod" value is passed, then pass the parameter to cloudformation
if [ $1 ]; then 
   echo "Inside if, parameter is $1" 

   if [ $1 == "prod" ]; then 
      params="--parameters ParameterKey=environment,ParameterValue=prod" 
   else 
      params="--parameters ParameterKey=environment,ParameterValue=dev" 
   fi
fi

echo params = $params 

cmd="aws cloudformation describe-stacks --stack-name nw --query \"Stacks[0].StackName\" --output  text" 
status=$(eval "$cmd" 2>/dev/null) 
 if [[ $status == "nw" ]]
    then
       echo "Network Stack already exists, not creating again... "
       exit 0 
 fi


aws cloudformation create-stack --stack-name nw --template-body file://network.yaml $params
 # Throw error message if there is an issue 
 if [[ $? -ne 0 ]]
    then
       echo "inside if" 
       echo $msg 
       echo ".... some issue, exiting "
       exit -1
 fi

aws cloudformation wait stack-create-complete --stack-name nw

 # Throw error message if there is an issue 
 if [[ $? -ne 0 ]]
    then
       echo ".... some issue, exiting "
       exit -1
 fi

# To pass different environment information 
# ./create_stack.sh --parameters ParameterKey=environment,ParameterValue=prod
