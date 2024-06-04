variable "subscription_id" {
  description = "id for the subscription where role assignment is applied"
  type        = string
}

variable "rg_name" {
  description = "name of the resource group where role assignment is applied"
  type        = string
}

variable "credential_subject" {
  description = "Subject for the federated identity credential"
  type        = string
  sensitive   = true
}