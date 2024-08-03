variable "groups" {
  type = map(object({
    name = string
  }))
}

resource "aws_iam_group" "groups" {
  for_each = var.groups
  name     = each.value.name
}
