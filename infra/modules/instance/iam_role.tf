resource "aws_iam_role" "ecr_access_role" {
  assume_role_policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
      {
        "Effect": "Allow",
        "Principal": {
          "Service": "ec2.amazonaws.com"
        },
        "Action": "sts:AssumeRole"
      }
    ]
  })

}

resource "aws_iam_role_policy" "ecr_role_access_policy" {
  policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
      {
        "Effect": "Allow",
        "Action": [
          "ecr:GetDownloadUrlForLayer",
          "ecr:BatchGetImage",
          "ecr:DescribeImages",
          "ecr:GetAuthorizationToken",
          "ecr:ListImages"
        ],
        "Resource": "*"
      }
    ]
  })
  role = aws_iam_role.ecr_access_role.id
}

resource "aws_iam_instance_profile" "ecr_profile" {
  name = "${var.instance_name}ecr_profile"
  role = aws_iam_role.ecr_access_role.name
}