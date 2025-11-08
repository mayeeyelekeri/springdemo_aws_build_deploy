#!/bin/bash 

# just call the script which takes care of creating parameters 
. ~/INFO/secrets/ecs_params.sh  $1
 
./createRepository.sh 

./pushDockerImageToECR.sh
