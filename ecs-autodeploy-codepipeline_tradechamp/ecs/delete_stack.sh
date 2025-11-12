aws cloudformation delete-stack --stack-name ecs

aws cloudformation wait stack-delete-complete --stack-name ecs
