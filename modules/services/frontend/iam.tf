/**
# IAM ( ECS )
# Task Role と Task Execution Role は兼用とします。
*/
resource "aws_iam_role" "ecs_frontend_task_role" {
  name = "${var.common.project}-ecs-frontend-task-role-${var.common.environment}-${var.sfx}"

  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "ecs-tasks.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
POLICY

  tags = {
    Name        = "${var.common.project}-ecs-frontend-task-role-${var.common.environment}-${var.sfx}"
    Environment = var.common.environment
    Createdby   = "Terraform"
  }
}

/**
# IAM Policy ( ECS Task Execution )
*/
resource "aws_iam_role_policy_attachment" "ecs_frontend_task_execution" {
  role       = aws_iam_role.ecs_frontend_task_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

/** 
# Secrets Manager 読み込み ポリシー
*/
data "aws_iam_policy_document" "ecs_frontend_to_secrets" {
  statement {
    actions = [
      "secretsmanager:DescribeSecret",
      "secretsmanager:ListSecrets",
      "ecs:DescribeTasks",
    ]
    resources = var.ecs_frontend_to_secrets
  }
}

resource "aws_iam_policy" "ecs_frontend_to_secrets" {
  name   = "${var.common.project}-${var.common.environment}-ecs-frontend-to-secrets-policy-${var.sfx}"
  path   = "/"
  policy = data.aws_iam_policy_document.ecs_frontend_to_secrets.json

  tags = {
    Name        = "${var.common.project}-${var.common.environment}-ecs-frontend-to-secrets-policy-${var.sfx}"
    Environment = var.common.environment
    Createdby   = "Terraform"
  }
}

resource "aws_iam_role_policy_attachment" "ecs_frontend_to_secrets" {
  role       = aws_iam_role.ecs_frontend_task_role.name
  policy_arn = aws_iam_policy.ecs_frontend_to_secrets.arn
}

/**
# IAM Policy ( Access ECS to S3 media-file )
*/
data "aws_iam_policy_document" "ecs_frontend_to_media_file" {
  statement {
    actions = [
      "s3:GetObject*",
      "s3:PutObject*",
      "s3:DeleteObject*",
    ]
    resources = [
      "arn:aws:s3:::${var.common.project}-${var.common.environment}-media-file-s3-bucket-${var.sfx}",
      "arn:aws:s3:::${var.common.project}-${var.common.environment}-media-file-s3-bucket-${var.sfx}/*",
    ]
  }
}

resource "aws_iam_policy" "ecs_frontend_to_media_file" {
  name   = "${var.common.project}-${var.common.environment}-ecs-frontend-to-media-file-policy-${var.sfx}"
  path   = "/"
  policy = data.aws_iam_policy_document.ecs_frontend_to_media_file.json

  tags = {
    Name        = "${var.common.project}-${var.common.environment}-ecs-frontend-to-media-file-policy-${var.sfx}"
    Environment = var.common.environment
    Createdby   = "Terraform"
  }
}

resource "aws_iam_role_policy_attachment" "ecs_to_media_file" {
  role       = aws_iam_role.ecs_frontend_task_role.name
  policy_arn = aws_iam_policy.ecs_frontend_to_media_file.arn
}
