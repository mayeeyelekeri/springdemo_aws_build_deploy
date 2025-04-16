aws cloudformation delete-stack --stack-name codepipeline

# Wait for the stack creation complete
aws cloudformation wait stack-delete-complete --stack-name codepipeline
