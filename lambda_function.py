import json

def lambda_handler(event, context):
    json_data = {
        #input your resume.json
    }

    json_str = json.dumps(json_data, indent=2)

    return {
        'statusCode': 200,
        'body': json_str
    }
