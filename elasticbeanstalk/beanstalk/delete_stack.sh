aws cloudformation delete-stack --stack-name beanstalk

# Wait for the stack creation complete
aws cloudformation wait stack-delete-complete --stack-name beanstalk
