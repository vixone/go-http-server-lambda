provider "aws" {
  region = "us-east-1"
}

resource "aws_lambda_function" "go_lambda" {
  function_name    = "go_lambda_function"
  role            = aws_iam_role.lambda_exec.arn
  handler         = "go-server"
  runtime         = "go1.x"
  filename        = "go-server.zip"
  source_code_hash = filebase64sha256("go-server.zip")
}

resource "aws_iam_role" "lambda_exec" {
  name = "lambda_exec_role"

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

resource "aws_iam_policy_attachment" "lambda_logs" {
  name       = "lambda_logs"
  roles      = [aws_iam_role.lambda_exec.name]
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}
