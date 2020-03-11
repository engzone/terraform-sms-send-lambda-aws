resource "aws_iam_role" "lambda_exec_role" {
  name               = "lambda_exec_role"
  assume_role_policy = data.aws_iam_policy_document.lambda_assume_role.json
}

resource "aws_iam_role_policy" "lambda_exec_policy" {
  name   = "lambda_iam_policy"
  role   = aws_iam_role.lambda_exec_role.id
  policy = data.aws_iam_policy_document.lambda_permissions.json
}

resource "aws_lambda_function" "this" {
  filename         = "lambda_code/sms-send.zip"
  source_code_hash = data.archive_file.source.output_base64sha256
  function_name    = "sms-send-lambda"
  role             = aws_iam_role.lambda_exec_role.arn
  handler          = "handler.lambda_handler"
  runtime          = "python3.6"
  timeout          = 120
}
