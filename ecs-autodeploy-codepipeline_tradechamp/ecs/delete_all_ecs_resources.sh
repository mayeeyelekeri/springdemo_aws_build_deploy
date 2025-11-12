#!/bin/bash 

# Executes command function 
function executeCmd { 
   local cmd="$1"
   `$cmd`  
} 

# cluster name 
cluster="mycluster" 
service="manualservice"

# stop all tasks 
length=`aws ecs list-tasks --cluster $cluster --query "length(taskArns)"`
echo "# of tasks = $length" 

if [ $length -ge 1 ]; then
   echo "Tasks exist, going to delete all..." 

   while [ $length -ge 1 ]; do 
     echo "inside while, length = $length" 
     ((length--)) 
     
     # Get the ARN of the task 
     cmd="aws ecs list-tasks --cluster $cluster --query \"taskArns[$length]\""    
     echo $cmd
     taskArn=$(eval $cmd) 
     echo "task ARN: $taskArn" 

     # Get Task-ID from ARN 
     cmd="aws ecs describe-tasks --cluster $cluster --tasks $taskArn --query \"tasks[$length].attachments[0].id\""
     echo $cmd 
     taskId=$(eval $cmd) 
     echo "task ID: $taskId" 

     # Delete Task 
     cmd="aws ecs stop-task --task $taskId" 
     echo $cmd
     eval $cmd 

   done  # end of while loop  
fi   # end of all tasks 

############### 
# Delete Service 
################
cmd="aws ecs delete-service --cluster $cluster --service $service --force" 
echo $cmd 
eval $cmd 

################
# delete all task definitions 
cmd="aws ecs list-task-definitions --query \"length(taskDefinitionArns)\""
echo $cmd 
length=$(eval $cmd) 

echo "# of task definitions = $length" 
if [ $length -ge 1 ]; then
   echo "Task definitions exist, going to delete all..." 

   while [ $length -ge 1 ]; do 
     echo "inside while, length = $length" 
     ((length--)) 
     
     # Get the ARN of the task def
     cmd="aws ecs list-task-definitions --query \"taskDefinitionArns[$length]\""
     echo $cmd
     taskDefArn=$(eval $cmd) 
     echo "task ARN: $taskDefArn" 

     # Delete Task definition 
     cmd="aws ecs deregister-task-definition --task-definition $taskDefArn" 
     echo $cmd
     eval $cmd 
   done  # end of while loop  
fi   # end of all tasks 


############### 
# Delete Cluster 
################
cmd="aws ecs delete-cluster --cluster $cluster"  
echo $cmd 
eval $cmd 
