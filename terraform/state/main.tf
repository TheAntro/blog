resource "azurerm_resource_group" "tfstate" {
  name     = "tfstate"
  location = var.location
}

resource "random_id" "stg_acc_suffix" {
  byte_length = 4
}

resource "azurerm_storage_account" "strg_acc" {
  name                            = "tfstate${random_id.stg_acc_suffix.hex}"
  location                        = var.location
  resource_group_name             = azurerm_resource_group.tfstate.name
  account_replication_type        = "LRS"
  account_tier                    = "Standard"
  allow_nested_items_to_be_public = false
}

resource "azurerm_storage_container" "blob_container" {
  name                  = "tfstate"
  storage_account_name  = azurerm_storage_account.strg_acc.name
  container_access_type = "private"
}