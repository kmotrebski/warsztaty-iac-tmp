
output "instance_ip" {
  value = aws_eip.ip.public_ip
}
