variable "org_id" {
  type = string
}

variable "billing_account_id" {
  type = string
}

variable "project_a" { 
  default = "c01-proj-a" 
}

variable "project_b" { 
  default = "c01-proj-b" 
}

variable "region" { 
  default = "asia-southeast1" 
}

variable "zone" { 
default = "asia-southeast1-a" 
}

variable "ctf_users_group" {
  default = "ctf-users@yourdomain.com"
}
