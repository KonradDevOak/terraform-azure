resource "azapi_resource" "rg" {
  type      = "Microsoft.Resources/resourceGroups@2024-07-01"
  name      = "rg-${var.application_name}-${var.environment_name}"
  location  = var.primary_location
  parent_id = "/subscriptions/${data.azapi_client_config.current.subscription_id}"
}

data "azapi_client_config" "current" {
}

resource "azapi_resource" "vm_pip" {
  type      = "Microsoft.Network/publicIPAddresses@2024-05-01"
  name      = "pip-${var.application_name}-${var.environment_name}"
  parent_id = azapi_resource.rg.id
  location  = azapi_resource.rg.location

  body = {
    properties = {
      publicIPAllocationMethod = "Static"
      publicIPAddressVersion   = "IPv4"
    }
    sku = {
      name = "Standard"
    }
  }
}

data "azapi_resource" "network_rg" {
  name      = "rg-network-dev"
  parent_id = "/subscriptions/${data.azapi_client_config.current.subscription_id}"
  type      = "Microsoft.Resources/resourceGroups@2024-07-01"
}

data "azapi_resource" "vnet" {
  name      = "vnet-network-dev"
  parent_id = data.azapi_resource.network_rg.id
  type      = "Microsoft.Network/virtualNetworks@2024-05-01"
}

data "azapi_resource" "subnet_beta" {
  name      = "snet-beta"
  parent_id = data.azapi_resource.vnet.id
  type      = "Microsoft.Network/virtualNetworks/subnets@2024-05-01"

  response_export_values = ["name"]
}

resource "azapi_resource" "vm_nic" {
  type      = "Microsoft.Network/networkInterfaces@2024-05-01"
  name      = "nic-${var.application_name}-${var.environment_name}"
  parent_id = azapi_resource.rg.id
  location  = azapi_resource.rg.location

  body = {
    properties = {
      ipConfigurations = [
        {
          name = "public"
          properties = {
            privateIPAllocationMethod = "Dynamic"
            subnet = {
              id = data.azapi_resource.subnet_beta.id
            }
            publicIPAddress = {
              id = azapi_resource.vm_pip.id
            }
          }
        }
      ]
    }
  }
}

resource "tls_private_key" "vm" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

data "azapi_resource" "devops_rg" {
  name      = "rg-devops-dev"
  parent_id = "/subscriptions/${data.azapi_client_config.current.subscription_id}"
  type      = "Microsoft.Resources/resourceGroups@2024-07-01"
}

data "azapi_resource" "keyvault" {
  name      = "kv-devops-dev-s6368h"
  parent_id = data.azapi_resource.devops_rg.id
  type      = "Microsoft.KeyVault/vaults@2024-12-01-preview"
}

resource "azapi_resource" "vm_ssh_private" {
  type                      = "Microsoft.KeyVault/vaults/secrets@2024-12-01-preview"
  name                      = "azapivm-ssh-private"
  parent_id                 = data.azapi_resource.keyvault.id
  schema_validation_enabled = false

  body = {
    properties = {
      value = tls_private_key.vm.private_key_pem
    }
  }

  lifecycle {
    ignore_changes = [body]
  }
}

resource "azapi_resource" "vm_ssh_public" {
  type      = "Microsoft.KeyVault/vaults/secrets@2024-12-01-preview"
  name      = "azapivm-ssh-private"
  parent_id = data.azapi_resource.keyvault.id

  body = {
    properties = {
      value = tls_private_key.vm.public_key_openssh
    }
  }
}

resource "azapi_resource" "vm" {
  type      = "Microsoft.Compute/virtualMachines@2024-07-01"
  name      = "vm${var.application_name}${var.environment_name}"
  parent_id = azapi_resource.rg.id
  location  = azapi_resource.rg.location

  body = {
    properties = {
      osProfile = {
        adminUsername = "adminuser"
        computerName  = "vm${var.application_name}${var.environment_name}"
        linuxConfiguration = {
          ssh = {
            publicKeys = [
              {
                keyData = tls_private_key.vm.public_key_openssh
                path    = "/home/adminuser/.ssh/authorized_keys"
              }
            ]
          }
        }
      }
      storageProfile = {
        imageReference = {
          offer     = "0001-com-ubuntu-server-jammy"
          publisher = "Canonical"
          sku       = "22_04-lts"
          version   = "latest"
        }
        osDisk = {
          caching      = "ReadWrite"
          createOption = "FromImage"
          managedDisk = {
            storageAccountType = "Standard_LRS"
          }
        }
      }
      hardwareProfile = {
        vmSize = "Standard_B1ls"
      }
      networkProfile = {
        networkInterfaces = [
          {
            id = azapi_resource.vm_nic.id
          }
        ]
      }
    }
  }
}
