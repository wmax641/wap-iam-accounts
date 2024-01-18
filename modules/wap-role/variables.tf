variable "name" {
  type        = string
  description = "Name of the role"
}

variable "path" {
  type        = string
  default     = "/wap/"
  description = "Role for the IAM resource. Defaults to /wap/"
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "Additional tags to include in the IAM resource"
}

variable "assume_role_policy" {
  type        = string
  description = "Inline Assume role policy"
  default     = ""
}

variable "inline_policies" {
  type        = list(string)
  description = "Inline IAM policy document as list of JSONs. Each item generates a separate inline policy"
  default     = []
}

variable "managed_policy_arns" {
  type        = list(string)
  description = "List of managed ARN policies to attach"
  default     = []
}

variable "create_deploy_role" {
  type        = bool
  description = "Whether or not to create a Deploy Role. Defaults to false to create a serice role"
  default     = false
}

variable "used_by_repo" {
  type        = string
  description = "The repo that uses these roles"
}

variable "account_id_prd" {
  type    = string
  default = "640722323464"
}
variable "account_id_dev" {
  type    = string
  default = "071440211637"
}
