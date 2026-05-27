variable "group_path" {
  description = "Path for the IAM group"
  type        = string
  default     = "/"
}

variable "user_names" {
  description = "List of IAM user names to add to the group"
  type        = list(string)
}

variable "policy_arns" {
  description = "List of IAM policy ARNs to attach to the group"
  type        = list(string)
  default     = []
}
