# create s3 for storing state file
resource "aws_s3_bucket" "mystate_file" {
  bucket = var.s3_bucket_name
}

resource "aws_s3_bucket_versioning" "versioning_state" {
  bucket = aws_s3_bucket.mystate_file.id
  versioning_configuration {
    status = var.s3_versioning
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "mystate_file_sse_config" {
  bucket = aws_s3_bucket.mystate_file.id
  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}