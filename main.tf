resource "azurerm_resource_group" "rg" {
  name     = "${var.name}-${var.env}"
  location = var.location
}

resource "azurerm_kubernetes_cluster" "aks" {
  name                = "${var.name}-${var.env}"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  dns_prefix          = var.dnsprefix

  default_node_pool {
    name       = "default"
    node_count = 1
    vm_size    = "Standard_D2_v2"
  }

  service_principal {
    client_id     = "00000000-0000-0000-0000-000000000000"
    client_secret = "00000000000000000000000000000000"
  }

  identity {
      type = "SystemAssigned"
  }

  tags = {
    Environment = var.location
  }

  addon_profile {
    aci_connector_linux {
      enabled = false
    }

    azure_policy {
      enabled = false
    }

    http_application_routing {
      enabled = false
    }

    kube_dashboard {
      enabled = true
    }

    oms_agent {
      enabled = false
    }
  }

}

resource "azurerm_kubernetes_cluster_node_pool" "aks_node_pool" {
  name                  = "${var.name}-${var.env}"
  kubernetes_cluster_id = azurerm_kubernetes_cluster.aks.id
  vm_size               = "Standard_DS2_v2"
  node_count            = 1
  vnet_subnet_id        = var.subnet_id
}
