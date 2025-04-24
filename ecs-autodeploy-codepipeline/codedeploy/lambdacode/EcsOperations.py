import boto3 
import json

# reference: https://boto3.amazonaws.com/v1/documentation/api/latest/reference/services/ecs.html
def lambda_handler(event, context):
 
    ecs = boto3.client('ecs') 
    print("listing all clusters")
    print(ecs.list_clusters())
    
    print("listing all services")
    print(ecs.list_services(cluster='mycluster'))
    for serviceArn in ecs.list_services(cluster='mycluster')['serviceArns']:
        print(ecs.describe_services(cluster='mycluster', services=[serviceArn]))

    print("listing all tasks")
    print(ecs.list_tasks(cluster='mycluster', serviceName='manualservice'))
    for serviceArn in ecs.list_services(cluster='mycluster')['serviceArns']:
        print(ecs.describe_services(cluster='mycluster', services=[serviceArn]))
    
    for taskArn in ecs.list_tasks(cluster='mycluster', serviceName='manualservice')['taskArns']:
        print("describing task")
        print(ecs.describe_tasks(cluster='mycluster', tasks=[taskArn]))

    return {
        'statusCode': 200,
        'body': json.dumps('Hello from Lambda!')
    }

