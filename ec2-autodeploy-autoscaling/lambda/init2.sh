#!/bin/bash 

# Get codebuild bucket name 
# Add additional parameters 
codebuild_bucket_name=`aws ssm get-parameter --name /dev/codebuild/bucket_name --query "Parameter.Value" --output "text"`
echo $codebuild_bucket_name

# Upload all the lambda code to S3 bucket 
declare -a arr=("BeforeInstall" "AfterInstall" "BeforeAllowTraffic" "AfterAllowTraffic" "AfterAllowTestTraffic" "rand2") 
length=${#arr[@]} 
for (( i=0; i<${length}; i++)); 
do
  echo "${arr[$i]}" 
  cmd="aws s3 cp lambdacode/zip/${arr[$i]}.zip s3://$codebuild_bucket_name" 
  echo $cmd
  eval $cmd
  if [[ $? -ne 0 ]]
    then
       echo ".... some issue with uploading Lambda code, exiting "
       exit -1
  fi
 
done 

 
