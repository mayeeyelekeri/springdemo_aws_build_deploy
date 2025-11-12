aws cloudformation delete-stack --stack-name codebuild

# Wait for the stack creation complete
aws cloudformation wait stack-delete-complete --stack-name codebuild
