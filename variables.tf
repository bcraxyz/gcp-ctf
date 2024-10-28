variable "project_id" {
  description = "The project ID to create"
  type        = string
}

variable "project_name" {
  description = "The display name of the project"
  type        = string
}

variable "region" {
  description = "The region to create resources in"
  type        = string
}

variable "org_id" {
  description = "The organization ID"
  type        = string
}

variable "billing_account" {
  description = "The billing account ID"
  type        = string
}
