resource "aws_iam_policy_attachment" "policies" {
  for_each = var.policies
  name     = each.value.name
  groups   = [each.value.group]
  policy_arn = each.value.policy_arn
}

