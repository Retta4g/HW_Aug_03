output "user_names" {
  value = [for u in aws_iam_user.users : u.name]
}

output "user_arns" {
  value = [for u in aws_iam_user.users : u.arn]
}
