aws cloudformation delete-stack --stack-name autoscale

# Wait for the stack creation complete
aws cloudformation wait stack-delete-complete --stack-name autoscale
