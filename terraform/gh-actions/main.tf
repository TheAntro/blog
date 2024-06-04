resource "azuread_application_registration" "github" {
  display_name = "Github Actions"
}

resource "azuread_service_principal" "github" {
  client_id = azuread_application_registration.github.client_id
}

resource "azurerm_role_assignment" "github" {
  role_definition_name = "Contributor"
  scope                = "/subscriptions/${var.subscription_id}/resourceGroups/${var.rg_name}"
  principal_id         = azuread_service_principal.github.object_id
  principal_type       = "ServicePrincipal"
}

resource "azuread_application_federated_identity_credential" "github" {
  application_id = "applications/${azuread_application_registration.github.object_id}"
  display_name   = "github-actions"
  description    = "Deployments for blog"
  audiences      = ["api://AzureADTokenExchange"]
  issuer         = "https://token.actions.githubusercontent.com"
  subject        = var.credential_subject
}