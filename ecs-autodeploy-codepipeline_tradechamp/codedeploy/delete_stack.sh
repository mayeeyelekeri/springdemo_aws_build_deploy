aws cloudformation delete-stack --stack-name codedeploy

# Wait for the stack creation complete
aws cloudformation wait stack-delete-complete --stack-name codedeploy
