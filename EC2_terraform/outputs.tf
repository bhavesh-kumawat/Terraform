output "public_ip" {
  value = aws_instance.my_ec2_instance.public_ip
}

output "public_dns" {
  value = aws_instance.my_ec2_instance.public_dns
}

output "private_ip" {
  value = aws_instance.my_ec2_instance.private_ip
}

# use this when use count to Launch multiple instances
# output "public_ip" {
#   value = aws_instance.my_ec2_instance[*].public_ip
# }

# output "public_dns" {
#   value = aws_instance.my_ec2_instance[*].public_dns
# }

# output "private_ip" {
#   value = aws_instance.my_ec2_instance[*].private_ip
# }



# use this when use for_each to Launch multiple instances
# output "public_ip" {
#   value = {
#     for key in aws_aws_instance.my_ec2_instance : key.public_ip
#   }
# }