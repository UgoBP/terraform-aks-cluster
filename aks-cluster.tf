# Copyright (c) HashiCorp, Inc.
# SPDX-License-Identifier: MPL-2.0

# resource "random_pet" "prefix" {}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "default" {
  name     = "terra-rg"
  location = "East US"

  tags = {
    environment = "Demo"
  }
}

resource "azurerm_kubernetes_cluster" "default" {
  name                = "terra-aks"
  location            = "East US"
  resource_group_name = azurerm_resource_group.default.name
  dns_prefix          = "terra-k8s"
  # kubernetes_version  = "1.26.3"

  default_node_pool {
    name            = "default"
    node_count      = 2
    vm_size         = "Standard_D2_v2"
    os_disk_size_gb = 30
  }

  service_principal {
    client_id     = var.appId
    client_secret = var.password
  }

  role_based_access_control_enabled = true

  tags = {
    environment = "Demo"
  }
}
