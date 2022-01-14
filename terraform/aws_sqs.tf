resource "aws_sqs_queue" "sample-queue" {
  name                      = "sample-queue"
  delay_seconds             = 90
  max_message_size          = 2048
  message_retention_seconds = 86400
  receive_wait_time_seconds = 10
  sqs_managed_sse_enabled   = true
}

resource "aws_sqs_queue" "sample-dlq" {
  name = "sample-dlq"
}
