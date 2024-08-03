output "group_names" {
  value = [for g in aws_iam_group.groups : g.name]
}

output "group_arns" {
  value = [for g in aws_iam_group.groups : g.arn]
}


