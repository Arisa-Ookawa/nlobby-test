/**
# IAM Role ( ECS )
*/
resource "aws_iam_role" "ecs_ws_task_role" {
  name = "${var.common.project}-${var.common.environment}-ecs-ws-task-role-${var.sfx}"

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
    Name        = "${var.common.project}-${var.common.environment}-ecs-ws-task-role-${var.sfx}"
    Environment = var.common.environment
    Createdby   = "Terraform"
  }
}

/**
# IAM Policy ( ECS Task Execution )
*/
resource "aws_iam_role_policy_attachment" "ecs_ws_task_execution" {
  role       = aws_iam_role.ecs_ws_task_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

/**
# Secret Manager 読み込み ポリシー
*/
data "aws_iam_policy_document" "ecs_ws_secrets" {
  statement {
    actions = [
      "secretsmanager:DescribeSecret",
      "secretsmanager:ListSecrets",
      "secretsmanager:GetSecretValue",
      "ecs:DescribeTasks",
    ]
    resources = [aws_secretsmanager_secret.this.arn]
  }
}

resource "aws_iam_policy" "ecs_ws_secrets" {
  name   = "${var.common.project}-${var.common.environment}-ecs-ws-secrets-policy-${var.sfx}"
  path   = "/"
  policy = data.aws_iam_policy_document.ecs_ws_secrets.json

  tags = {
    Name        = "${var.common.project}-${var.common.environment}-ecs-ws-secrets-policy-${var.sfx}"
    Environment = var.common.environment
    Createdby   = "Terraform"
  }
}

resource "aws_iam_role_policy_attachment" "ecs_ws_secrets" {
  role       = aws_iam_role.ecs_ws_task_role.name
  policy_arn = aws_iam_policy.ecs_ws_secrets.arn
}

/**
# IAM Role ( GitHub Actions )
*/
resource "aws_iam_role" "gha_ws_deploy" {
  name               = "${var.common.project}-${var.common.environment}-gha-ws-deploy-role-${var.sfx}"
  assume_role_policy = data.aws_iam_policy_document.gha_ws_deploy.json

  tags = {
    Name        = "${var.common.project}-${var.common.environment}-ws-deploy-role-${var.sfx}"
    Environment = var.common.environment
    Createdby   = "Terraform"
  }
}

data "aws_iam_policy_document" "gha_ws_deploy" {
  statement {
    effect = "Allow"

    principals {
      type        = "Federated"
      identifiers = ["arn:aws:iam::${data.aws_caller_identity.self.account_id}:oidc-provider/token.actions.githubusercontent.com"]
    }

    actions = ["sts:AssumeRoleWithWebIdentity"]

    condition {
      test     = "StringEquals"
      variable = "token.actions.githubusercontent.com:aud"
      values   = ["sts.amazonaws.com"]
    }

    condition {
      test     = "StringLike"
      variable = "token.actions.githubusercontent.com:sub"
      values   = ["repo:${var.repository}:*"]
    }
  }
}

/**
# IAM Policy ( GitHub Actions )
*/
data "aws_iam_policy_document" "ws_deploy" {
  statement {
    actions = [
      "ecs:DescribeServices",
      "ecs:UpdateService",
      "ecs:RegisterTaskDefinition",
    ]
    resources = [
      "arn:aws:ecs:*:${data.aws_caller_identity.self.account_id}:cluster/${var.common.project}-${var.common.environment}-ws-cluster-${var.sfx}",
      "arn:aws:ecs:*:${data.aws_caller_identity.self.account_id}:service/${var.common.project}-${var.common.environment}-ws-cluster-${var.sfx}/${var.common.project}-${var.common.environment}-ws-service-${var.sfx}",
      "arn:aws:ecs:*:${data.aws_caller_identity.self.account_id}:task-definition/${var.common.project}-${var.common.environment}-ws-task-${var.sfx}:*"
    ]
  }

  statement {
    actions = [
      "ecr:BatchCheckLayerAvailability",
      "ecr:PutImage",
      "ecr:InitiateLayerUpload",
      "ecr:UploadLayerPart",
      "ecr:CompleteLayerUpload",
      "ecr:BatchGetImage",
      "ecr:GetDownloadUrlForLayer"
    ]
    resources = [
      "arn:aws:ecr:*:${data.aws_caller_identity.self.account_id}:repository/${var.common.project}-${var.common.environment}-ws-repository-${var.sfx}"
    ]
  }

  statement {
    actions = [
      "ecr:GetAuthorizationToken",
    ]
    resources = [
      "*"
    ]
  }

  statement {
    actions = [
      "iam:PassRole"
    ]
    resources = [
      "*"
    ]
  }
}

resource "aws_iam_policy" "ws_deploy" {
  name   = "${var.common.project}-${var.common.environment}-ws-deploy-policy-${var.sfx}"
  path   = "/"
  policy = data.aws_iam_policy_document.ws_deploy.json

  tags = {
    Name        = "${var.common.project}-${var.common.environment}-ws-deploy-policy-${var.sfx}"
    Environment = var.common.environment
    Createdby   = "Terraform"
  }
}

resource "aws_iam_role_policy_attachment" "ws_deploy" {
  role       = aws_iam_role.gha_ws_deploy.name
  policy_arn = aws_iam_policy.ws_deploy.arn
}
