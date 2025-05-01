#!/bin/bash 

# bash internal command to get the elapsed time 
SECONDS=0

#### For signature error, run the command
sudo /home/vagrant/scripts/clock_reset.sh

# Create the basis stack (will create network permissions alb codebuild)  
(cd ../basic_nw && ./create_all.sh) 

# Delete EC2 instance which was started, we don't need that anymore here'
cmd="aws ec2 describe-instances --query \"Reservations[0].Instances[0].InstanceId\" --output text" 
instanceId=$(eval $cmd) 

echo "terminating instance $instanceId" 
cmd="aws ec2 terminate-instances --instance-ids $instanceId" 
status=$(eval $cmd)  

# now process all other stacks 
dirs=(permissions2 lambda alb autoscale codedeploy codepipeline) 

# Change into each directory and execute create stack script 
for i in "${dirs[@]}"
do 
   echo Creating $i stack .... 
   (cd $i && ./create_stack.sh)
   echo .. done creating $i stack!!! 
done 

echo "Elapsed Time to create all stacks: $(($SECONDS / 60)) minutes and $(($SECONDS % 60)) seconds"
