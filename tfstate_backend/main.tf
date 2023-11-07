resource "random_id" "suffix" {
  byte_length = 8
}

resource "aws_s3_bucket" "backend" {
  bucket = "uad-customer-terraform-state-${random_id.suffix.hex}"

  tags = {
    env = "customer"
  }
}

resource "aws_s3_bucket_versioning" "versioning_example" {
  bucket = aws_s3_bucket.backend.id

  versioning_configuration {
    status = "Enabled"
  }
}
