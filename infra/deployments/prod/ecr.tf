resource "aws_ecr_repository" "php" {
  name = "php"
  image_tag_mutability = "MUTABLE"
  force_delete = true
}

resource "aws_ecr_lifecycle_policy" "main" {
  policy     = jsonencode({
    rules = [{
      rulePriority = 1
      description  = "keep last 10 images"
      action       = {
        type = "expire"
      }
      selection     = {
        tagStatus   = "any"
        countType   = "imageCountMoreThan"
        countNumber = 10
      }
    }]
  })
  repository = aws_ecr_repository.php.name
}

output "repository_url" {
  value = aws_ecr_repository.php.repository_url
}
