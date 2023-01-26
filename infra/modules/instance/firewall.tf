resource "aws_security_group" "firewall" {

}

resource "aws_security_group_rule" "allow_ssh_access" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  security_group_id = aws_security_group.firewall.id
  cidr_blocks = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "allow_port_80_in" {
  type = "ingress"
  from_port = 80
  to_port = 80
  protocol = "tcp"
  security_group_id = aws_security_group.firewall.id
  cidr_blocks = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "access_to_outside_world" {
  type              = "egress"
  to_port           = 0
  protocol          = "-1"
  from_port         = 0
  security_group_id = aws_security_group.firewall.id
  cidr_blocks = ["0.0.0.0/0"]
}
