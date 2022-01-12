resource "aws_s3_bucket" "b" {
  bucket = "sample_bucket"
  acl    = "private"

  tags = {
    "CreatedAt" = "20220112"
  }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }
}
