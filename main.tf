resource "aws_lambda_function" "ResumeChallengeAPI" {
    filename = data.archive_file.lambda_python_zip.output_path
    source_code_hash = data.archive_file.lambda_python_zip.output_base64sha256
    function_name = "ResumeChallengeAPI"
    role = aws_iam_role.iam_for_lambda.arn
    handler = "lambda_function.lambda_handler"
    runtime = "python3.9"
  
}

resource "aws_iam_role" "iam_for_lambda" {
    name = "iam_for_lambda"
    assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
  
}

resource "aws_iam_policy" "iam_lambda_logs" {
  name = "lambda_logs"
  path        = "/"
  description = "IAM policy for logging from a lambda"
  policy      = jsonencode(
    {
      "Version" : "2012-10-17",
      "Statement" : [
        {
          "Action" : [
            "logs:CreateLogGroup",
            "logs:CreateLogStream",
            "logs:PutLogEvents"
          ],
          "Resource" : "arn:aws:logs:*:*:*",
          "Effect" : "Allow"
        }
      ]
  })
}

resource "aws_iam_role_policy_attachment" "lambda_logs" {
  role       = aws_iam_role.iam_for_lambda.name
  policy_arn = aws_iam_policy.iam_lambda_logs.arn
}

data "archive_file" "lambda_python_zip" {
  type        = "zip"
  source_file = "${path.module}/lambda/lambda_function.py"
  output_path = "${path.module}/lambda.zip"
}

resource "aws_lambda_function_url" "test_live" {
  function_name      = aws_lambda_function.ResumeChallengeAPI.function_name
  authorization_type = "NONE"

  cors {
    allow_credentials = true
    allow_origins     = ["*"]
    allow_methods     = ["*"]
    allow_headers     = ["date", "keep-alive"]
    expose_headers    = ["keep-alive", "date"]
    max_age           = 86400
  }
}

