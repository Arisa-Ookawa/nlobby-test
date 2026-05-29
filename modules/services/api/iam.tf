/**
# IAM ( ECS )
# Task Role と Task Execution Role は兼用とします。
*/
resource "aws_iam_role" "ecs_api_task_role" {
  name = "${var.common.project}-ecs-api-task-role-${var.common.environment}-${var.sfx}"

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
    Name        = "${var.common.project}-ecs-api-task-role-${var.common.environment}-${var.sfx}"
    Environment = var.common.environment
    Createdby   = "Terraform"
  }
}

/**
# IAM Policy ( ECS Task Execution )
*/
resource "aws_iam_role_policy_attachment" "ecs_api_task_execution" {
  role       = aws_iam_role.ecs_api_task_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

/** 
# Secrets Manager 読み込み ポリシー
*/
data "aws_iam_policy_document" "ecs_api_to_secrets" {
  statement {
    actions = [
      "secretsmanager:DescribeSecret",
      "secretsmanager:ListSecrets",
      "ecs:DescribeTasks",
    ]
    resources = [aws_secretsmanager_secret.this.arn]
  }
}

resource "aws_iam_policy" "ecs_api_to_secrets" {
  name   = "${var.common.project}-${var.common.environment}-ecs-api-to-secrets-policy-${var.sfx}"
  path   = "/"
  policy = data.aws_iam_policy_document.ecs_api_to_secrets.json

  tags = {
    Name        = "${var.common.project}-${var.common.environment}-ecs-api-to-secrets-policy-${var.sfx}"
    Environment = var.common.environment
    Createdby   = "Terraform"
  }
}

resource "aws_iam_role_policy_attachment" "ecs_api_to_secrets" {
  role       = aws_iam_role.ecs_api_task_role.name
  policy_arn = aws_iam_policy.ecs_api_to_secrets.arn
}

/**
# IAM Policy ( Access ECS to S3 media-file )
*/
data "aws_iam_policy_document" "ecs_api_to_media_file" {
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

resource "aws_iam_policy" "ecs_api_to_media_file" {
  name   = "${var.common.project}-${var.common.environment}-ecs-api-to-media-file-policy-${var.sfx}"
  path   = "/"
  policy = data.aws_iam_policy_document.ecs_api_to_media_file.json

  tags = {
    Name        = "${var.common.project}-${var.common.environment}-ecs-api-to-media-file-policy-${var.sfx}"
    Environment = var.common.environment
    Createdby   = "Terraform"
  }
}

resource "aws_iam_role_policy_attachment" "ecs_to_media_file" {
  role       = aws_iam_role.ecs_api_task_role.name
  policy_arn = aws_iam_policy.ecs_api_to_media_file.arn
}

/**
# EventBridge
*/
resource "aws_iam_role" "event_bridge_api" {
  name = "${var.common.project}-event-bridge-api-role-${var.common.environment}-${var.sfx}"

  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "events.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
POLICY

  tags = {
    Name        = "${var.common.project}-event-bridge-api-role-${var.common.environment}-${var.sfx}"
    Environment = var.common.environment
    Createdby   = "Terraform"
  }
}

data "aws_iam_policy_document" "event_bridge_api" {
  statement {
    effect = "Allow"
    actions = [
      "events:InvokeApiDestination"
    ]
    resources = [
      "arn:aws:events:ap-northeast-1:133775794121:api-destination/nlobby-test-ao-staging-form-update-batch-01/*",
      "arn:aws:events:ap-northeast-1:133775794121:api-destination/nlobby-test-ao-staging-push-notify-batch-01/*",
      "arn:aws:events:ap-northeast-1:133775794121:api-destination/nlobby-test-ao-staging-token-update-batch-01/*",
      "arn:aws:events:ap-northeast-1:133775794121:api-destination/nlobby-test-ao-staging-get-batch-01/*"
    ]
  }
  statement {
    actions = [
      "secretsmanager:CreateSecret",
      "secretsmanager:UpdateSecret",
      "secretsmanager:DescribeSecret",
      "secretsmanager:DeleteSecret",
      "secretsmanager:GetSecretValue",
      "secretsmanager:PutSecretValue"
    ]
    resources = [
      "arn:aws:events:ap-northeast-1:133775794121:api-destination/nlobby-test-staging-api-destination-01/*"
    ]
  }
}

resource "aws_iam_policy" "event_bridge_api" {
  name   = "${var.common.project}-${var.common.environment}-event-bridge-api-${var.sfx}"
  path   = "/"
  policy = data.aws_iam_policy_document.event_bridge_api.json

  tags = {
    Name        = "${var.common.project}-${var.common.environment}-event-bridge-api-${var.sfx}"
    Environment = var.common.environment
    Createdby   = "Terraform"
  }
}

resource "aws_iam_role_policy_attachment" "event_bridge_api" {
  role       = aws_iam_role.event_bridge_api.name
  policy_arn = aws_iam_policy.event_bridge_api.arn
}

/**
# IAM Policy ( GitHub Actions )
*/
# resource "aws_iam_role" "gha_api_deploy" {
#   name               = "${var.common.project}-${var.common.environment}-gha-api-deploy-role-${var.sfx}"
#   assume_role_policy = data.aws_iam_policy_document.gha_api_deploy.json
# 
#   tags = {
#     Name        = "${var.common.project}-${var.common.environment}-api-deploy-role-${var.sfx}"
#     Environment = var.common.environment
#     Createdby   = "Terraform"
#   }
# }
# 
# data "aws_iam_policy_document" "gha_api_deploy" {
#   statement {
#     effect = "Allow"
# 
#     principals {
#       type        = "Federated"
#       identifiers = ["arn:aws:iam::${data.aws_caller_identity.self.account_id}:oidc-provider/token.actions.githubusercontent.com"]
#     }
# 
#     actions = ["sts:AssumeRoleWithWebIdentity"]
# 
#     condition {
#       test     = "StringEquals"
#       variable = "token.actions.githubusercontent.com:aud"
#       values   = ["sts.amazonaws.com"]
#     }
# 
#     condition {
#       test     = "StringLike"
#       variable = "token.actions.githubusercontent.com:sub"
#       values   = ["repo:${var.repository}:*"]
#     }
#   }
# }

/**
# IAM Policy ( GitHub Actions )
*/
# data "aws_iam_policy_document" "api_deploy" {
#   statement {
#     actions = [
#       "ecs:DescribeServices",
#       "ecs:UpdateService",
#       "ecs:RegisterTaskDefinition",
#     ]
#     resources = [
#       "arn:aws:ecs:*:${data.aws_caller_identity.self.account_id}:cluster/${var.common.project}-${var.common.environment}-api-cluster-${var.sfx}",
#       "arn:aws:ecs:*:${data.aws_caller_identity.self.account_id}:service/${var.common.project}-${var.common.environment}/${var.common.project}-${var.common.environment}-api-service-${var.sfx}",
#       "arn:aws:ecs:*:${data.aws_caller_identity.self.account_id}:task-definition/${var.common.project}-${var.common.environment}-api-task-${var.sfx}:*"
#     ]
#   }
# 
#   statement {
#     actions = [
#       "ecr:BatchCheckLayerAvailability",
#       "ecr:PutImage",
#       "ecr:InitiateLayerUpload",
#       "ecr:UploadLayerPart",
#       "ecr:CompleteLayerUpload",
#     ]
#     resources = [
#       "arn:aws:ecr:*:${data.aws_caller_identity.self.account_id}:repository/${var.common.project}-${var.common.environment}-api-repository-${var.sfx}"
#     ]
#   }
# 
#   statement {
#     actions = [
#       "ecr:GetAuthorizationToken",
#     ]
#     resources = [
#       "*"
#     ]
#   }
# 
#   statement {
#     actions = [
#       "iam:PassRole"
#     ]
#     resources = [
#       "*"
#     ]
#   }
# }
# 
# resource "aws_iam_policy" "api_deploy" {
#   name   = "${var.common.project}-${var.common.environment}-api-deploy-policy-${var.sfx}"
#   path   = "/"
#   policy = data.aws_iam_policy_document.api_deploy.json
# 
#   tags = {
#     Name        = "${var.common.project}-${var.common.environment}-api-deploy-policy-${var.sfx}"
#     Environment = var.common.environment
#     Createdby   = "Terraform"
#   }
# }
# 
# resource "aws_iam_role_policy_attachment" "api_deploy" {
#   role       = aws_iam_role.gha_api_deploy.name
#   policy_arn = aws_iam_policy.api_deploy.arn
# }
