#!/bin/bash 

echo "Invoking Lambda function rand() .... "
aws lambda invoke --function-name rand $(tty) >/dev/null
echo "" 

echo "Invoking Lambda function rand()  with alias.... "
aws lambda invoke --function-name rand:dev $(tty) >/dev/null
echo "" 

echo "Invoking Lambda function rand()  with version number.... "
aws lambda invoke --function-name rand:1 $(tty) >/dev/null
echo "" 


echo "Invoking Lambda function listBuckets() .... "
aws lambda invoke --function-name displayBuckets $(tty) >/dev/null
echo "" 
