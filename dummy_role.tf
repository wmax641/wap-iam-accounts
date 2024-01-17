module "test_role" {
  source = "./modules/wap-role"

  name = "WAPTestRole3"

  assume_role_policy = data.aws_iam_policy_document.test_role_assume_policy.json

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
