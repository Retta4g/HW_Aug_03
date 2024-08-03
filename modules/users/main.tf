variable "users" {
  type = map(object({
    name = string
  }))
}

resource "aws_iam_user" "users" {
  for_each = var.users
  name     = each.value.name
}
