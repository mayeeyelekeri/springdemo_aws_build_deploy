#!/bin/bash 

# bash internal command to get the elapsed time 
SECONDS=0

#### For signature error, run the command
sudo /usr/sbin/ntpdate pool.ntp.org

# Create the basis stack (will create network permissions alb codebuild)  
(cd ../basic_nw && ./create_all.sh) 

dirs=(permissions2 ecs codedeploy codepipeline) 

# Change into each directory and execute create stack script 
for i in "${dirs[@]}"
do 
   echo Creating $i stack .... 
   (cd $i && ./create_stack.sh)
   echo .. done creating $i stack!!! 
done 

echo "Elapsed Time to create all stacks: $(($SECONDS / 60)) minutes and $(($SECONDS % 60)) seconds"
