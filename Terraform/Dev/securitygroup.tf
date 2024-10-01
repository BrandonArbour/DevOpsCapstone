resource "aws_security_group" "allow_dev_access" {
  name        = "allow_dev_access"
  description = "Allow developer inbound traffic and all outbound traffic"
  vpc_id      = aws_vpc.dev_vpc.id

  tags = {
    Name = "allow_dev_access"
  }
}

resource "aws_vpc_security_group_ingress_rule" "allow_dev_ipv4_in" {
  security_group_id = aws_security_group.allow_dev_access.id
  cidr_ipv4         = var.dev_cidr_ipv4
  ip_protocol       = "-1"
}

resource "aws_vpc_security_group_egress_rule" "allow_all_ipv4_out" {
  security_group_id = aws_security_group.allow_dev_access.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"
}