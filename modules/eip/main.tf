resource "aws_eip" "nat_1a" {
  vpc = true

  tags = {
    Name = "${var.name_prefix}-eip"
  }
}