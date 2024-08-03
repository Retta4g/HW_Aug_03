variable "group_memberships" {
  type = map(object({
    group = string
    users = list(string)
  }))
}

resource "aws_iam_group_membership" "group_memberships" {
  for_each = var.group_memberships
  name     = "${each.value.group}-membership"
  group    = each.value.group
  users    = each.value.users
}
