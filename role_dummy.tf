module "test_role" {
  source = "./modules/wap-role"

  name = "WAPTestRole4"

  assume_role_policy = data.aws_iam_policy_document.test_role_assume_policy.json
  managed_policy_arns = [
    "arn:aws:iam::aws:policy/AmazonS3ReadOnlyAccess",
    "arn:aws:iam::aws:policy/AmazonEC2ReadOnlyAccess",
  ]
  inline_policies = [
    data.aws_iam_policy_document.inline_policy_0.json,
    data.aws_iam_policy_document.inline_policy_1.json,
  ]
  used_by_repo = "wmax641/wap-iam-test"
  tags         = { "additional" = "tag" }
}

module "test_deploy_role" {
  source = "./modules/wap-role"

  name = "WAPTestDeployRole4"

  assume_role_policy = data.aws_iam_policy_document.test_role_assume_policy.json
  managed_policy_arns = [
    "arn:aws:iam::aws:policy/AmazonS3ReadOnlyAccess",
    "arn:aws:iam::aws:policy/AmazonEC2ReadOnlyAccess",
  ]
  inline_policies = [
    data.aws_iam_policy_document.inline_policy_0.json,
    data.aws_iam_policy_document.inline_policy_1.json,
  ]
  create_deploy_role = true
  used_by_repo       = "wmax641/wap-iam-test"
  tags               = { "additional" = "tag" }
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

data "aws_iam_policy_document" "inline_policy_0" {
  statement {
    sid = "ec2stuff"
    actions = [
      "ec2:DescribeInstances",
    ]
    resources = ["*"]
  }
}

data "aws_iam_policy_document" "inline_policy_1" {
  statement {
    sid = "s3stuff"
    actions = [
      "s3:listBucket",
    ]

    resources = ["*"]
  }
}
