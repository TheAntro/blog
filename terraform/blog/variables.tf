variable "web_app_name" {
  description = "Name for the web app"
  type        = string
}

variable "rg_name" {
  description = "Name for the resource group"
  type        = string
}

variable "location" {
  description = "Region to deploy resource to"
  type        = string
  default     = "westeurope"
}

variable "domain_name" {
  description = "Custom domain name for the app"
  type        = string
}