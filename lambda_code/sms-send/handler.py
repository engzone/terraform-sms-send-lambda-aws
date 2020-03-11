import boto3

def lambda_handler(event, context):

    client = boto3.client("sns")

    topic = client.create_topic(Name=event['Topic'])
    topic_arn = topic['TopicArn']

    for number in event['Numbers']:
        client.subscribe(
            TopicArn=topic_arn,
            Protocol='sms',
            Endpoint=number
        )

    client.publish(Message=event['Message'], TopicArn=topic_arn)
