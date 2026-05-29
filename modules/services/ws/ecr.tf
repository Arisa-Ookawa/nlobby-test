/**
# ECR
*/
resource "aws_ecr_repository" "this" {
  name                 = "${var.common.project}-${var.common.environment}-ws-${var.sfx}"
  image_tag_mutability = var.ecr_repository.image_tag_mutability
  force_delete         = var.ecr_repository.force_delete

  image_scanning_configuration {
    scan_on_push = var.ecr_repository.scan_on_push
  }

  tags = {
    Name        = "${var.common.project}-${var.common.environment}-ws-${var.sfx}"
    Environment = var.common.environment
    Createdby   = "Terraform"
  }
}

resource "aws_ecr_lifecycle_policy" "this" {
  repository = aws_ecr_repository.this.name
  policy = jsonencode(
    {
      rules = [
        {
          action = {
            type = "expire"
          }
          description  = "Keep last ${var.ecr_repository.lifecycle_policy_count_number} images"
          rulePriority = 1
          selection = {
            countNumber = "${var.ecr_repository.lifecycle_policy_count_number}"
            countType   = "imageCountMoreThan"
            tagStatus   = "any"
          }
        },
      ]
    }
  )
}