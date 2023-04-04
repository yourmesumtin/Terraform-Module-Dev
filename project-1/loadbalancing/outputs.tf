#--------loadbalancing/outputs.tf-------

output "lb_target_group_arn" {
  value = aws_lb_target_group.your_tg.arn

}

output "lb_endpoint" {
  value = aws_lb.your_lb.dns_name

}