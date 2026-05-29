/** 
# EC2
*/
resource "aws_instance" "bastion" {
  ami                         = var.ami
  instance_type               = var.instance_type
  vpc_security_group_ids      = [aws_security_group.bastion.id]
  subnet_id                   = var.bastion_subnet_id
  iam_instance_profile        = aws_iam_instance_profile.bastion_profile.name
  user_data                   = file("${path.module}/scripts/userdata.sh")
  associate_public_ip_address = var.associate_public_ip_address


  root_block_device {
    volume_type           = var.root_block_device.volume_type
    volume_size           = var.root_block_device.volume_size
    delete_on_termination = var.root_block_device.delete_on_termination
  }

  tags = {
    Name        = "${var.common.project}-${var.common.environment}-bastion-ec2-${var.sfx}"
    Environment = var.common.environment
    Createdby   = "Terraform"
  }

  lifecycle {
    ignore_changes = [
      # NOTE: user_data を用いた構成管理は行わない。
      user_data,
    ]
    # TODO: Terraform 管理から全て外すことも検討する。
    //ignore_changes = all
  }
}

resource "aws_eip" "bastion" {
  instance = aws_instance.bastion.id

  tags = {
    Name        = "${var.common.project}-${var.common.environment}-bastion-eip-${var.sfx}"
    Environment = var.common.environment
    Createdby   = "Terraform"
  }
}

resource "aws_instance" "bastion_2" {
  ami                         = var.ami
  instance_type               = var.instance_type
  vpc_security_group_ids      = [aws_security_group.bastion.id]
  subnet_id                   = var.bastion_subnet_id
  iam_instance_profile        = aws_iam_instance_profile.bastion_profile.name
  user_data                   = file("${path.module}/scripts/userdata.sh")
  associate_public_ip_address = var.associate_public_ip_address


  root_block_device {
    volume_type           = var.root_block_device.volume_type
    volume_size           = var.root_block_device.volume_size
    delete_on_termination = var.root_block_device.delete_on_termination
  }

  tags = {
    Name        = "${var.common.project}-${var.common.environment}-bastion2-ec2-${var.sfx}"
    Environment = var.common.environment
    Createdby   = "Terraform"
  }

  lifecycle {
    ignore_changes = [
      # NOTE: user_data を用いた構成管理は行わない。
      user_data,
    ]
    # TODO: Terraform 管理から全て外すことも検討する。
    //ignore_changes = all
  }
}

resource "aws_eip" "bastion_2" {
  instance = aws_instance.bastion.id

  tags = {
    Name        = "${var.common.project}-${var.common.environment}-bastion2-eip-${var.sfx}"
    Environment = var.common.environment
    Createdby   = "Terraform"
  }
}