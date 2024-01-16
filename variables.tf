variable "base_name" {
  description = "Common prefix used for naming resources of this project"
  default = "wap-iam-accounts"
}
variable "common_tags" {
  description = "Common tags used in resources of this project"
  default = {
    "project" = "wap-iam-accounts"
  }
}

