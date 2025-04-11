#!/bin/bash

SECONDS=0

dirs=( ecs alb permissions network)

# Change into each directory and execute delete stack script
for i in "${dirs[@]}"
do
   echo deleting $i stack ....
   (cd $i && ./delete_stack.sh)
   echo .. done deleting $i stack!!!
done
echo "Elapsed Time to delete all stacks: $(($SECONDS / 60)) minutes and $(($SECONDS % 60)) seconds"
