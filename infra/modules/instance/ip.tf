#so that IP address does not change during instance lifetime
resource "aws_eip" "ip" {
  instance = aws_instance.instance.id
  vpc      = true
}
