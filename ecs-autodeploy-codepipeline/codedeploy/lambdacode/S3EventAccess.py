import json
import boto3 

def lambda_handler(event, context):
    # TODO implement
    print("event", event)
    s3 = boto3.client('s3') 
    bucket = event['Records'][0]['s3']['bucket']['name'] 
    key = event['Records'][0]['s3']['object']['key']
    print("bucket:", bucket) 
    print("object key:", key)
    bucketObject = event['Records'][0]['s3'] 
    print("bucketObject:", bucketObject)  

    print("bucket ARN", bucketObject['bucket']['arn']) 

    print("List all objects: ", s3.list_objects(Bucket=bucket))  

    for key in s3.list_objects(Bucket=bucket)['Contents']:
        print(key['Key'])
        
    return {
        'statusCode': 200,
        'body': json.dumps('Hello from Lambda!')
    }
