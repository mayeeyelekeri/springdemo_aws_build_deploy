#!/bin/bash 

SECONDS=0
dirs=(network permissions alb ecs) 

# Change into each directory and execute update stack script 
for i in "${dirs[@]}"
do 
   echo Updating $i stack .... 
   (cd $i && ./update_stack.sh)
   echo .. done updating $i stack!!! 
done 
echo "Elapsed Time to create update stacks: $(($SECONDS / 60)) minutes and $(($SECONDS % 60)) seconds"
