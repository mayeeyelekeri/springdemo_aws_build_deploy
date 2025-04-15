#!/bin/bash

SECONDS=0

dirs=(codepipeline codedeploy ecs alb permissions2)

# Change into each directory and execute delete stack script
for i in "${dirs[@]}"
do
   echo deleting $i stack ....
   (cd $i && ./delete_stack.sh)
   echo .. done deleting $i stack!!!
done

# Remove all the basic setup 
(cd ../basic_nw && ./delete_all.sh)

echo "Elapsed Time to delete all stacks: $(($SECONDS / 60)) minutes and $(($SECONDS % 60)) seconds"
