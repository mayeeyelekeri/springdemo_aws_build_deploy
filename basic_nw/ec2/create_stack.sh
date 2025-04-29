SECONDS=0
aws cloudformation create-stack --stack-name ec2 --template-body file://ec2.yaml  --capabilities CAPABILITY_NAMED_IAM $*

aws cloudformation wait stack-create-complete --stack-name ec2

# create AMI from the running ec2 instance 
instanceId=`aws ec2 describe-instances --query "Reservations[0].Instances[0].InstanceId" --output text`

`aws ec2 create-image --instance-id $instanceId --name "myDockerImage" --description "Docker Image with CodeDeploy agent"`

# Wait till the AMI is created, usually it takes few minutes, wait in a loop 
status=`aws ec2 describe-images --owners self --query "Images[0].State" --output text`

while [ "$status" != "available" ] 
do 
   sleep 5 
   status=`aws ec2 describe-images --owners self --query "Images[0].State" --output text`
   echo "status is $status" 
done 

echo "AMI is successfully created" 
imageId=`aws ec2 describe-images --owners self --query "Images[0].ImageId" --output text` 

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
