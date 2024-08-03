provider "aws" {
  region = "us-west-2"
}

locals {
  users = {
    sysadmin1    = { name = "sysadmin1" }
    sysadmin2    = { name = "sysadmin2" }
    dbadmin1     = { name = "dbadmin1" }
    dbadmin2     = { name = "dbadmin2" }
    monitoruser1 = { name = "monitoruser1" }
    monitoruser2 = { name = "monitoruser2" }
    monitoruser3 = { name = "monitoruser3" }
    monitoruser4 = { name = "monitoruser4" }
  }

  groups = {
    SysAdmin = { name = "SysAdmin" }
    DBAdmin  = { name = "DBAdmin" }
    Monitor  = { name = "Monitor" }
  }

  group_memberships = {
    sysadmin_membership = { group = "SysAdmin", users = ["sysadmin1", "sysadmin2"] }
    dbadmin_membership  = { group = "DBAdmin", users = ["dbadmin1", "dbadmin2"] }
    monitor_membership  = { group = "Monitor", users = ["monitoruser1", "monitoruser2", "monitoruser3", "monitoruser4"] }
  }

  policies = {
    SysAdminPolicy = {
      name      = "SysAdminPolicy"
      group     = "SysAdmin"
      policy_arn = "arn:aws:iam::aws:policy/job-function/SystemAdministrator"
    }
    DBAdminPolicy = {
      name      = "DBAdminPolicy"
      group     = "DBAdmin"
      policy_arn = "arn:aws:iam::aws:policy/AmazonRDSFullAccess"
    }
    MonitorPolicy = {
      name      = "MonitorPolicy"
      group     = "Monitor"
      policy_arn = "arn:aws:iam::aws:policy/AmazonRDSReadOnlyAccess"
    }
  }
}

module "users" {
  source = "./modules/users"
  users  = local.users
}

module "groups" {
  source = "./modules/groups"
  groups = local.groups
}

module "group_memberships" {
  source            = "./modules/group_memberships"
  group_memberships = local.group_memberships

  depends_on = [
    module.users,
    module.groups,
  ]
}

module "policies" {
  source   = "./modules/policies"
  policies = local.policies

  depends_on = [
    module.groups,
  ]
}



terraform { 
  cloud { 
    
    organization = "02-spring-cloud" 

    workspaces { 
      name = "workspace_aws_iam" 
    } 
  } 
}