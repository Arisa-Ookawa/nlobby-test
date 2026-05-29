/**
# IAM ( bastion )
*/
resource "aws_iam_role" "bastion_role" {
  name = "${var.common.project}-${var.common.environment}-bastion-iam-role-${var.sfx}"

  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
POLICY

  tags = {
    Name        = "${var.common.project}-${var.common.environment}-bastion-iam-role-${var.sfx}"
    Environment = var.common.environment
    Createdby   = "Terraform"
  }
}

resource "aws_iam_instance_profile" "bastion_profile" {
  name = "${var.common.project}-${var.common.environment}-bastion-ec2-iam-profile-${var.sfx}"
  role = aws_iam_role.bastion_role.name

  tags = {
    Name        = "${var.common.project}-${var.common.environment}-bastion-ec2-iam-profile-${var.sfx}"
    Environment = var.common.environment
    Createdby   = "Terraform"
  }
}

/** 
# SSM 接続ポリシー
*/
data "aws_iam_policy_document" "ssm_start_session_staging" {
  statement {
    actions = [
      "ssm:StartSession",
      "ssm:GetConnectionStatus",
    ]
    effect    = "Allow"
    resources = ["*"]
    condition {
      test     = "StringEqualsIgnoreCase"
      variable = "aws:ResourceTag/Environment"
      values   = ["${var.common.environment}"]
    }
    condition {
      test     = "StringEqualsIgnoreCase"
      variable = "aws:ResourceTag/Project"
      values   = ["${var.common.project}"]
    }
  }

  statement {
    actions = [
      "ssm:StartSession"
    ]
    effect = "Allow"
    resources = [
      "arn:aws:ssm:ap-northeast-1:133775794121:document/SSM-StartPortForwardingSession",
      "arn:aws:ssm:ap-northeast-1:133775794121:document/SSM-SessionManagerRunShell"
    ]
  }

  statement {
    actions = [
      "ssm:DescribeInstanceInformation",
      "ssm:DescribeInstanceProperties"
    ]
    effect    = "Allow"
    resources = ["*"]
  }
}

resource "aws_iam_policy" "ssm_start_session_staging" {
  name   = "${var.common.project}-${var.common.environment}-ssm-start-session-nlobby-staging-${var.sfx}"
  path   = "/"
  policy = data.aws_iam_policy_document.ssm_start_session_staging.json

  tags = {
    Name        = "${var.common.project}-${var.common.environment}-ssm-start-session-nlobby-staging-${var.sfx}"
    Environment = var.common.environment
    Createdby   = "Terraform"
  }
}

resource "aws_iam_role_policy_attachment" "ec2_to_ssm" {
  role       = aws_iam_role.bastion_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}