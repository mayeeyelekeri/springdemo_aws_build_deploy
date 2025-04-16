#!/bin/bash

function executeCmd { 
  echo "cmd: $1" 
  `$cmd` 
  if [ $? -eq 0 ] 
  then 
    echo success command execution: $cmd
  else 
    echo ******* FAILED: $cmd
  fi
}

# Delete tasks 
count=`aws ecs  list-tasks   --cluster mycluster  --query "taskArns" | jq length`
i=0
while [ $i -le $count ]
do
  echo "deleting $i record"
  i=$(( $i + 1 ))
  executeCmd "ls -lrt "   
done

# Delete service 

# Delete tasks definitions 

# Delete cluster 

