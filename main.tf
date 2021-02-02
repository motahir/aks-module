resource "azurerm_resource_group" "rg" {
  name     = "${var.name}-${var.env}"
  location = var.location
}

resource "azurerm_kubernetes_cluster" "aks" {
  name                = "${var.name}-${var.env}"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  dns_prefix          = "${var.dnsprefix}-${var.env}"

  agent_pool_profile {
    name            = "agentpool"
    count           = 2
    vm_size         = "Standard_D1_v2"
    os_type         = "Linux"
    os_disk_size_gb = 30
    vnet_subnet_id  = var.subnet_id
  }

  service_principal {
    client_id     = var.app_id
    client_secret = var.password
  }

  tags = {
    Environment = var.location
  }

  network_profile {
    network_plugin = "azure"
    service_cidr = var.service_cidr
    dns_service_ip = var.dns_service_ip
    docker_bridge_cidr = var.docker_bridge_cidr
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
