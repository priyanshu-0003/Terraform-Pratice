
resource "aws_iam_role" "lambda_role" {
  name = "lambda_execution_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = "lambda.amazonaws.com"
      }
    }]
  })
}

resource "aws_iam_role_policy_attachment" "lambda_policy" {
  role       = aws_iam_role.lambda_role.name #attaching policy to role 
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

resource "aws_lambda_function" "my_lambda" {
  function_name = "my_lambda_function"
  role          =  aws_iam_role.lambda_role.arn #attahching role to lambda 
  handler       = "lambda_function.lambda_handler"
  runtime       = "python3.12"
  timeout       = 900
  memory_size   = 128
  filename = "lambda_function.zip"

 
  source_code_hash = filebase64sha256("lambda_function.zip")

  #Without source_code_hash, Terraform might not detect when the code in the ZIP file has changed — meaning your Lambda might not update even after uploading a new ZIP.

#This hash is a checksum that triggers a deployment.
}

#Implement Schdule base trigger to lambda function 
# Rule that fires on a schedule
resource "aws_cloudwatch_event_rule" "schedule_rule" {
  name                = "lambda_schedule_rule"
  description         = "Triggers Lambda every 5 minutes"
  schedule_expression = "rate(5 minutes)"
  # Or use cron: "cron(0 12 * * ? *)"  -> every day at 12:00 UTC
}

# Connect the rule to the Lambda
resource "aws_cloudwatch_event_target" "schedule_target" {
  rule      = aws_cloudwatch_event_rule.schedule_rule.name
  target_id = "my_lambda_target"
  arn       = aws_lambda_function.my_lambda.arn
}

# Permission so EventBridge is allowed to invoke Lambda
resource "aws_lambda_permission" "allow_eventbridge" {
  statement_id  = "AllowExecutionFromEventBridge"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.my_lambda.function_name
  principal     = "events.amazonaws.com"
  source_arn    = aws_cloudwatch_event_rule.schedule_rule.arn
}

#Implment Event base process to lmabda function
resource "aws_s3_bucket" "my_bucket" {
  bucket = "my-lambda-trigger-bucket-12345"  # must be globally unique
}

# Permission so S3 can invoke Lambda
resource "aws_lambda_permission" "allow_s3" {
  statement_id  = "AllowExecutionFromS3"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.my_lambda.function_name
  principal     = "s3.amazonaws.com"
  source_arn    = aws_s3_bucket.my_bucket.arn
}

# Notification: when a file is created, call Lambda
resource "aws_s3_bucket_notification" "bucket_notification" {
  bucket = aws_s3_bucket.my_bucket.id

  lambda_function {
    lambda_function_arn = aws_lambda_function.my_lambda.arn
    events              = ["s3:ObjectCreated:*"]
    filter_suffix       = ".csv"   # optional
  }

  depends_on = [aws_lambda_permission.allow_s3]
}