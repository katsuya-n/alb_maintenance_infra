resource "aws_instance" "web" {
  // 検証で使いたいだけなのでAMI IDを直接指定
  ami                    = "ami-0e4d9ed95865f3b40"
  instance_type          = "t3.micro"
  vpc_security_group_ids = [var.sg_id]
  subnet_id              = var.subnet_id
  key_name               = var.key_name

  tags = {
    Name = "${var.name_prefix}-web"
  }
}

resource "aws_instance" "bastion" {
  // 検証で使いたいだけなのでAMI IDを直接指定
  ami                         = "ami-0e4d9ed95865f3b40"
  instance_type               = "t3.micro"
  vpc_security_group_ids      = [var.bastion_sg_id]
  subnet_id                   = var.bastion_subnet_id
  key_name                    = var.key_name
  associate_public_ip_address = "true"

  tags = {
    Name = "${var.name_prefix}-bastion"
  }
}