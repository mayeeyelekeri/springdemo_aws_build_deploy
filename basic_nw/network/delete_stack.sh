aws cloudformation delete-stack --stack-name nw

# Wait for the stack deletion complete
aws cloudformation wait stack-delete-complete --stack-name nw
