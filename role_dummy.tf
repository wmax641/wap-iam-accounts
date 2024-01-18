module "test_role" {
  source = "./modules/wap-role"

  name = "WAPTestRole4"

  assume_role_policy = data.aws_iam_policy_document.test_role_assume_policy.json
  managed_policy_arns = [
    "arn:aws:iam::aws:policy/AmazonS3ReadOnlyAccess",
    "arn:aws:iam::aws:policy/AmazonEC2ReadOnlyAccess",
  ]

  tags = { "additional" = "tag" }
}

data "aws_iam_policy_document" "test_role_assume_policy" {
  statement {
    actions = [
      "sts:AssumeRole",
    ]
    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}
