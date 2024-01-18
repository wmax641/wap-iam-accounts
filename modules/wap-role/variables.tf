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
}

variable "inline_polices" {
  type        = list(string)
  description = "Inline IAM policy document as list of JSONs. Each item generates a separate inline policy"
  default     = []
}

variable "managed_policy_arns" {
  type        = list(string)
  description = "List of managed ARN policies to attach"
  default     = []
}

variable "permission_boundary" {
  type        = string
  description = "Name of permission boundary. Defaults to WAPServicePermissionBoundary if unset "
  default     = "WAPServicePermissionBoundary"
}
