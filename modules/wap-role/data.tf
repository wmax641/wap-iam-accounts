data "aws_region" "current" {}
data "aws_caller_identity" "current" {}

data "aws_iam_policy" "permission_boundary_service" {
  name        = "WAPServicePermissionBoundary"
  path_prefix = "/boundary/"
}

data "aws_iam_policy" "permission_boundary_deploy" {
  name        = "WAPDeployPermissionBoundary"
  path_prefix = "/boundary/"
}

data "aws_iam_openid_connect_provider" "github" {
  url = "https://token.actions.githubusercontent.com"
}

data "aws_iam_policy_document" "deploy_role_assume_role_policy" {
  statement {
    actions = [
      "sts:AssumeRoleWithWebIdentity",
    ]

    principals {
      type        = "Federated"
      identifiers = ["${data.aws_iam_openid_connect_provider.github.arn}"]
    }

    condition {
      test     = "StringEquals"
      variable = "token.actions.githubusercontent.com:aud"

      values = [
        "sts.amazonaws.com",
      ]
    }
    condition {
      test     = "StringLike"
      variable = "token.actions.githubusercontent.com:sub"

      values = flatten([
        "repo:${var.used_by_repo}:environment:production",
        data.aws_caller_identity.current.account_id == var.account_id_dev ? ["repo:${var.used_by_repo}:environment:development"] : [],
      ])
    }
  }
}

data "aws_iam_policy_document" "deploy_role_policy" {
  statement {
    sid = "s3ListBucket"
    actions = [
      "s3:ListBucket",
    ]
    resources = ["tf-${data.aws_caller_identity.current.account_id}"]
  }
  statement {
    sid = "readWriteTerrformStateS3"
    actions = [
      "s3:GetObject",
      "s3:PutObject",
    ]
    resources = ["tf-${data.aws_caller_identity.current.account_id}/${var.used_by_repo}"]
  }
  statement {
    sid = "dynamodb"
    actions = [
      "dynamodb:DescribeTable",
      "dynamodb:GetItem",
      "dynamodb:PutItem",
      "dynamodb:DeleteItem",
    ]
    resources = ["arn:aws:dynamodb:*:*:table/tf-${data.aws_caller_identity.current.account_id}"]
  }
}
