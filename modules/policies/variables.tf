variable "policies" {
  type = map(object({
    name       = string
    group      = string
    policy_arn = string
  }))
}
