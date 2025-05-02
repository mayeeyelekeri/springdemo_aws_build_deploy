SECONDS=0

# verify if stack already exists                                                                                       
cmd="aws cloudformation describe-stacks --stack-name ec2 --query \"Stacks[0].StackName\" --output  text"             
status=$(eval "$cmd" 2>/dev/null)
 if [[ $status == "ec2" ]]                                                                                           
    then                                                                                                               
       echo "ec2 Stack already exists, not creating again... "                                                       
       exit 0                                                                                                          
 fi                                                                                                                    


aws cloudformation create-stack --stack-name ec2 --template-body file://ec2.yaml  --capabilities CAPABILITY_NAMED_IAM $*
# Throw error message if there is an issue
 if [[ $? -ne 0 ]]
    then
       echo ".... some issue, exiting "
       exit -1
 fi

aws cloudformation wait stack-create-complete --stack-name ec2
# Throw error message if there is an issue
 if [[ $? -ne 0 ]]
    then
       echo ".... some issue, exiting "
       exit -1
 fi

# create AMI from the running ec2 instance 
instanceId=`aws ec2 describe-instances --query "Reservations[0].Instances[0].InstanceId" --output text`

cmd="aws ec2 create-image --instance-id $instanceId --name \"myDockerImage\" --description \"Docker Image with CodeDeploy agent\""
echo $cmd 
status=$(eval $cmd)

# Wait till the AMI is created, usually it takes few minutes, wait in a loop 
cmd="aws ec2 describe-images --owners self --query \"Images[0].State\" --output text"
echo $cmd 
status=$(eval $cmd)

while [ "$status" != "available" ] 
do 
   sleep 10 
   cmd="aws ec2 describe-images --owners self --query \"Images[0].State\" --output text"
   echo $cmd 
   status=$(eval $cmd)
   echo "status is $status" 
    
   # break away from loop if image creation is not initiated 
    if [[ "$status" == "None" ]] 
    then 
       echo ".... some issue, exiting " 
       exit -1 	
    fi 

done 

echo "AMI is successfully created" 
cmd="aws ec2 describe-images --owners self --query \"Images[0].ImageId\" --output text" 
echo $cmd 
imageId=$(eval $cmd)

echo "AMI ID: $imageId" 

# Add ImageID to parameter store 
aws ssm put-parameter \
    --name "/dev/ec2/my_docker_image_id" \
    --type "String" \
    --value "$imageId" \
    --overwrite
 
# To pass different environment information 
# ./create_stack.sh --parameters ParameterKey=environment,ParameterValue=prod
echo "Elapsed Time to create EC2 stack: (using \$SECONDS): $SECONDS  seconds"
