#!/bin/bash 

SECONDS=0

# Update all the basic stacks first 
(cd ../basic_nw && ./update_all.sh)

dirs=(permissions2 lambda alb ecs codedeploy codepipeline) 

# Change into each directory and execute update stack script 
for i in "${dirs[@]}"
do 
   echo Updating $i stack .... 
   (cd $i && ./update_stack.sh)
   echo .. done updating $i stack!!! 
done 
echo "Elapsed Time to create update stacks: $(($SECONDS / 60)) minutes and $(($SECONDS % 60)) seconds"
