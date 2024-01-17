resource "aws_iam_role" "wap_role" {
  name                = var.name
  path                = var.path
  assume_role_policy  = var.assume_role_policy
  managed_policy_arns = var.managed_policy_arns
  tags                = merge({ "Name" = var.name, "repo" = "wmax641/wap-iam-accounts" }, var.tags)
}
