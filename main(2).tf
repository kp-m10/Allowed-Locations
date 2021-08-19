provider "azurerm" {
  version = "2.68.0"
  features {}
}

resource "azurerm_policy_definition" "policy" {
  name         = "allowedlocations"
  policy_type  = "Custom"
  mode         = "Indexed"
  display_name = var.name
  description  = "This policy enables you to restrict the locations your organization can specify when deploying resources. Use to enforce your geo-compliance requirements. Excludes resource groups, Microsoft.AzureActiveDirectory/b2cDirectories, and resources that use the 'global' region."

  metadata = <<METADATA
    {
    "version": "1.0.0",
    "category": "${var.policy_definition_category}"
    }

METADATA

  policy_rule = <<POLICY_RULE
    {
      "if": {
        "allOf": [
          {
            "field": "location",
            "notIn": "[parameters('listOfAllowedLocations')]"
          },
          {
            "field": "location",
            "notEquals": "global"
          },
          {
            "field": "type",
            "notEquals": "Microsoft.AzureActiveDirectory/b2cDirectories"
          }
        ]
      },
      "then": {
        "effect": "deny"
      }
    }
POLICY_RULE


  parameters = <<PARAMETERS
  {
      "listOfAllowedLocations": {
        "type": "Array",
        "metadata": {
          "description": "The list of locations that can be specified when deploying resources.",
          "strongType": "location",
          "displayName": "Allowed locations"
        }
      }
    }
    
PARAMETERS

}
resource "azurerm_policy_assignment" "example" {
  count                = "${length(var.subscription)}"
  name                 = "allowed-locations-policy-assignment"
  scope                = "/subscriptions/${var.subscription[count.index]}"
  policy_definition_id = azurerm_policy_definition.policy.id
  description          = "Policy Assignment created for Allowed Locations"
  display_name         = var.assign_name

  metadata = <<METADATA
    {
    "category": "${var.policy_definition_category}"
    }
METADATA

  parameters = jsonencode({
  "listOfAllowedLocations": {
    "value":  var.location,
  }
}
  )
}


