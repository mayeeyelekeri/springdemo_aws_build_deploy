#!/bin/bash 

SECONDS=0 
environment=dev 

if [ $1 ]; then 
	echo inside if condition, env requested $1 
	environment=$1 
fi
 
#### For signature error, run the command
sudo /home/vagrant/scripts/clock_reset.sh

. ~/INFO/secrets/aws_secrets.sh 

echo environment is $environment 
./network/init.sh $1
./permissions/init.sh $1
./codebuild/init.sh $1

start=$(date +%s) 
echo "Elapsed Time: $(($SECONDS / 60)) minutes and $(($SECONDS % 60)) seconds"
