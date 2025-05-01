aws cloudformation delete-stack --stack-name lambda

# Wait for the stack creation complete
aws cloudformation wait stack-delete-complete --stack-name lambda
