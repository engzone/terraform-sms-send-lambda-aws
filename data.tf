data "archive_file" "source" {
  type        = "zip"
  source_dir  = "lambda_code/sms-send"
  output_path = "lambda_code/sms-send.zip"
}

data "aws_iam_policy_document" "lambda_assume_role" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }
  }
}

data "aws_iam_policy_document" "lambda_permissions" {
  statement {
    actions = [
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:PutLogEvents",
      "sns:CreateTopic",
      "sns:Subscribe",
      "sns:Publish"
    ]

    resources = [
      "*"
    ]
  }
}
