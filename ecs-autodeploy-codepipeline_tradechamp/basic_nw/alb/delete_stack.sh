aws cloudformation delete-stack --stack-name alb

# Wait for the stack creation complete
aws cloudformation wait stack-delete-complete --stack-name alb
