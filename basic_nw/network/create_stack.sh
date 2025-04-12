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

aws cloudformation create-stack --stack-name nw --template-body file://network.yaml $params

aws cloudformation wait stack-create-complete --stack-name nw

# To pass different environment information 
# ./create_stack.sh --parameters ParameterKey=environment,ParameterValue=prod
