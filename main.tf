# Molecule: IAM Group with Membership and Policy Attachment
module "group" {
  source = "git::https://github.com/PlatformStackPulse/tf-atom-iam-group-aws.git?ref=f1fe9ff624f88849e444a5eeec742fcdf1db0aae"

  context = module.this.context
  path    = var.group_path
}

module "membership" {
  source = "git::https://github.com/PlatformStackPulse/tf-atom-iam-group-membership-aws.git?ref=6e75789fbc02bb8c143b2d41a9e0a9f58e3125cf"

  context    = module.this.context
  group_name = module.group.group_name
  user_names = var.user_names

  depends_on = [module.group]
}

module "policy_attachment" {
  source = "git::https://github.com/PlatformStackPulse/tf-atom-iam-group-policy-attachment-aws.git?ref=f7a7e022bc1ea05d0c6199b8234e3e44654597e2"

  for_each = toset(var.policy_arns)

  context    = module.this.context
  group_name = module.group.group_name
  policy_arn = each.value

  depends_on = [module.group]
}
