packer {
  required_plugins {
    azure = {
      version = ">= 2.0.0"
      source  = "github.com/hashicorp/azure"
    }
  }
}

locals {
    
}


source "azure-arm" "ubuntu"{
    os-type = "Linux"
    build_resource_group_name = "var.az_resource_group"
    vm_size = "Standard"
    
    # Source image
    image_publisher = "Canonical"
    image_offer     = "UbuntuServer"
    image_sku       = "16.04.0-LTS"
    image_version   = "latest"
    
    # Destination image



    use_azure_cli_auth = true

    # Spot instance settings
    spot {
        eviction_policy = "Delete"
        max_price       = "0.4"
    }


    # Authentication type
    use_azure_cli_auth = true
}

