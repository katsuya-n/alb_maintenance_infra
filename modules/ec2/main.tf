resource "aws_instance" "web" {
  // 検証で使いたいだけなのでAMI IDを直接指定
  ami                    = "ami-0e4d9ed95865f3b40"
  instance_type          = "t3.micro"
  vpc_security_group_ids = [var.sg_id]
  subnet_id              = var.subnet_id

  tags = {
    Name = "${var.name_prefix}-web"
  }
}