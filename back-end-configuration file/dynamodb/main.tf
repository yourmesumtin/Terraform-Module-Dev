# # Create DynamoDB table for statelocking
# resource "aws_dynamodb_table" "statelocking" {
#   name         = var.db_table_name
#   hash_key     = var.hash_key
#   billing_mode = var.billing_mode

#   attribute {
#     name = var.attr_name
#     type = var.attr_type
#   }
# }