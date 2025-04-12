aws cloudformation delete-stack --stack-name ecs-part2

aws cloudformation wait stack-delete-complete --stack-name ecs-part2

aws cloudformation delete-stack --stack-name ecs-part1

aws cloudformation wait stack-delete-complete --stack-name ecs-part1

