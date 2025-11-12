#!/bin/bash 

# bash internal command to get the elapsed time 
SECONDS=0

executeCmd() { 
   $(eval $cmd)  

   if [[ $? -ne 0 ]]
   then 
     echo "stack $i has errors, quitting" 
     exit -1 
   fi 
} 

dirs=(ec2) 

# Change into each directory and execute create stack script 
for i in "${dirs[@]}"
do 
   echo Creating $i stack .... 
   (cd $i && ./test.sh)
   echo .. done creating $i stack!!! 
done 

echo "Elapsed Time to create all BASIC stacks: $(($SECONDS / 60)) minutes and $(($SECONDS % 60)) seconds"

