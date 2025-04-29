aws cloudformation delete-stack --stack-name utils

# Wait for the stack creation complete
aws cloudformation wait stack-delete-complete --stack-name utils
