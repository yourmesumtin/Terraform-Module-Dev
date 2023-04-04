# module "s3" {
#   source         = "./s3"
#   s3_bucket_name = "mys3statelocking2023"
#   s3_versioning  = var.s3_versioning
# }

# module "dynamodb" {
#   source        = "./dynamodb"
#   db_table_name = var.db_table_name
#   billing_mode  = var.billing_mode
#   hash_key      = var.hash_key
#   attr_name     = var.attr_name
#   attr_type     = var.attr_type

# }
