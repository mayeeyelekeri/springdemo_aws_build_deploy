aws cloudformation delete-stack --stack-name ec2

aws cloudformation wait stack-delete-complete --stack-name ec2
