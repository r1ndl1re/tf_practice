provider "aws" {
  region = "ap-northeast-1"

  access_key = "mock_access_key"
  secret_key = "mock_secret_key"

  s3_force_path_style         = true
  skip_credentials_validation = true
  skip_metadata_api_check     = true
  skip_requesting_account_id  = true

  endpoints {
    iam     = "http://host.docker.internal:4566"
    kinesis = "http://host.docker.internal:4566"
    lambda  = "http://host.docker.internal:4566"
    s3      = "http://host.docker.internal:4566"
    ec2     = "http://host.docker.internal:4566"
    sqs     = "http://host.docker.internal:4566"
  }

  default_tags {
    tags = {
      Service = "Others"
    }
  }
}
