locals {
  inline_policy_map = { for idx, val in var.inline_policies : idx => val }
}
