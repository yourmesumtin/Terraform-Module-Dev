# #------root/variables.tf---------

# variable "aws_region" {
#   default = "us-west-2"

# }

# #------- s3 variables-------------

# variable "s3_bucket_name" {
#   description = "s3 bucket name"
#   type        = string
#   default     = "null"
# }
# variable "s3_versioning" {
#   default = "Enabled"
# }


# #-------- DynamoDB variables----------

# variable "db_table_name" {
#   default = "state-lock"
#   type = string
# }
# variable "billing_mode" {
#   type    = string
#   default = "PAY_PER_REQUEST"
# }
# variable "hash_key" {
#   type    = string
#   default = "LockID"
# }
# variable "attr_name" {
#   type    = string
#   default = "LockID"
# }
# variable "attr_type" {
#   type    = string
#   default = "S"
# }