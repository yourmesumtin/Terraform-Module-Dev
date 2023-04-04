#---networking/outputs.tf
output "vpc_id" {
  value = aws_vpc.your_vpc.id
}

output "db_subnet_group_name" {
  value = aws_db_subnet_group.your_rds_subnetgroup.*.name

}

output "db_security_group" {
  value = [aws_security_group.your_sg["rds"].id]
}

output "public_sg" {
  value = [aws_security_group.your_sg["public"].id]

}

output "public_subnets" {
  value = aws_subnet.your_public_subnet.*.id

}