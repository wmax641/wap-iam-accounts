resource "aws_iam_role" "wap_role" {
  name = var.name
  path = var.path

  managed_policy_arns  = var.managed_policy_arns
  permissions_boundary = var.create_deploy_role ? data.aws_iam_policy.permission_boundary_deploy : data.aws_iam_policy.permission_boundary_service.arn

  dynamic "inline_policy" {
    for_each = local.inline_policy_map
    content {
      name   = "${var.name}-InlinePolicy-${each.key}"
      policy = each.value
    }
  }

  # If creating a deploy role, use the Assume Role policy
  # Otherwise use provided assumption policy
  assume_role_policy = var.create_deploy_role ? data.aws_iam_policy_document.deploy_role_assume_role_policy.json : var.assume_role_policy

  tags = merge({
    "Name"         = var.name,
    "repo"         = "wmax641/wap-iam-accounts",
    "used_by_repo" = var.used_by_repo,
  }, var.tags)
}
