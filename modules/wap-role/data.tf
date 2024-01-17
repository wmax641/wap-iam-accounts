#
#
#data "aws_iam_policy_document" "assume_role_policy" {
#  statement {
#    actions = [
#      "sts:AssumeRoleWithWebIdentity",
#    ]
#
#    principals {
#      type        = "Federated"
#      identifiers = ["${aws_iam_openid_connect_provider.github_actions.arn}"]
#    }
#
#    condition {
#      test     = "StringEquals"
#      variable = "token.actions.githubusercontent.com:aud"
#
#      values = [
#        "sts.amazonaws.com",
#      ]
#    }
#    condition {
#      test     = "StringLike"
#      variable = "token.actions.githubusercontent.com:sub"
#
#      values = flatten([
#        "repo:wmax641/wap-iam-accounts:environment:production",
#        data.aws_caller_identity.current.account_id == var.account_id_dev ? ["repo:wmax641/wap-iam-accounts:environment:development"] : [],
#      ])
#    }
#  }
#}
