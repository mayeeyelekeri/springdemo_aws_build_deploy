aws cloudformation delete-stack --stack-name perm

# Wait for the stack deletion complete
aws cloudformation wait stack-delete-complete --stack-name perm
