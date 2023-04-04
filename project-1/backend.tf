# terraform {
#   backend "s3" {
#     bucket         = "mys3statelocking2023"
#     dynamodb_table = "state-lock"
#     key            = "global/mystatefile/terraform.tfstate"
#     region         = "us-west-2"
#     encrypt        = true
#   }
# }
