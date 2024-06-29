import json

def lambda_handler(event, context):
    json_data = {
        "basics": {
            "name": "Alex Tabisz",
            "label": "Developer",
            "image": "",
            "email": "alextabisz5@gmail.com",
            "phone": "(732) 749-2824",
            "url": "https://github.com/AlexTabisz",
            "location": {
                "postalCode": "NJ 07101",
                "city": "Newark",
                "countryCode": "US",
                "region": "New Jersey"
            },
            "profiles": [{
                "network": "LinkedIn",
                "username": "AlexTabisz",
                "url": "https://www.linkedin.com/in/alex-tabisz-7450a5254/"
            }]
        },
        "work": [{
            "name": "Soccer Post",
            "position": "Associate",
            "startDate": "07-11-2022",
            "endDate": "09-06-2023",
            "summary": "Description…"
        }],
        "education": [{
            "institution": "Rutgers University-Newark",
            "area": "Management Information Systems and Computer Science",
            "studyType": "Bachelor",
            "startDate": "09-06-2019",
            "endDate": "05-15-2024"
        }],
        "certificates": [{
            "name": "AWS Solutions Architect - Associate Certification",
            "date": "04-26-2024",
            "issuer": "AMAZON WEB SERVICE",
            "url": "https://www.credly.com/badges/10eb2390-dcde-40d5-96e3-66ac193b3204/public_url"
        }],
        "skills": [{
            "name": "Cloud Computing",
            "level": "Master",
            "keywords": [
                "Terraform",
                "Python",
                "AWS",
                "Docker"
            ]
        }],
        "languages": [{
            "language": "English, Portuguese",
            "fluency": "Native speaker"
        }]
    }

    json_str = json.dumps(json_data, indent=2)

    return {
        'statusCode': 200,
        'body': json_str
    }
