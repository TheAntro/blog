terraform {
  required_version = ">= 1.1.0"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.106"
    }
  }
  backend "azurerm" {
    resource_group_name  = "tfstate"
    storage_account_name = "tfstate02b6908d"
    container_name       = "tfstate"
    key                  = "blog.tfstate"
  }
}

provider "azurerm" {
  features {}
}