output "enabled" {
  description = "Whether the module is enabled"
  value       = local.enabled
}

output "group_arn" {
  description = "ARN of the IAM group"
  value       = module.group.group_arn
}

output "group_name" {
  description = "Name of the IAM group"
  value       = module.group.group_name
}

output "users" {
  description = "List of users in the group"
  value       = module.membership.users
}
