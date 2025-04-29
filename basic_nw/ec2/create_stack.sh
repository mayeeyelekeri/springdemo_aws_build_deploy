SECONDS=0
aws cloudformation create-stack --stack-name ec2 --template-body file://ec2.yaml  --capabilities CAPABILITY_NAMED_IAM $*

aws cloudformation wait stack-create-complete --stack-name ec2


status=`aws ec2 describe-images --owners self --query "Images[0].State" --output text`

while [ "$status" != "available" ] 
do 
   sleep 2 
   status=`aws ec2 describe-images --owners self --query "Images[0].State" --output text`
   echo "status is $status" 
done 

echo "AMI is successfully created" 
imageId=`aws ec2 describe-images --owners self --query "Images[0].ImageId" --output text` 

echo "AMI ID: $imageId" 

# Add ImageID to parameter store 
aws ssm put-parameter \
    --name "/dev/ec2/dockerImageID" \
    --type "String" \
    --value "$imageId" \
    --overwrite
 
# To pass different environment information 
# ./create_stack.sh --parameters ParameterKey=environment,ParameterValue=prod
echo "Elapsed Time to create EC2 stack: (using \$SECONDS): $SECONDS  seconds"
