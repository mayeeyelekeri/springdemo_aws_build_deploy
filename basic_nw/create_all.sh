#!/bin/bash 

# bash internal command to get the elapsed time 
SECONDS=0

#### For signature error, run the command
sudo /home/vagrant/scripts/clock_reset.sh

dirs=(network permissions utils ec2 codebuild) 

# Change into each directory and execute create stack script 
for i in "${dirs[@]}"
do 
   echo Creating $i stack .... 
   (cd $i && ./create_stack.sh)
   echo .. done creating $i stack!!! 
done 

echo "Elapsed Time to create all BASIC stacks: $(($SECONDS / 60)) minutes and $(($SECONDS % 60)) seconds"
