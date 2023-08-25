packer {
  required_plugins {
    azure = {
      version = ">= 2.0.0"
      source  = "github.com/hashicorp/azure"
    }
  }
}

locals {
    timestamp = regex_replace(timestamp(), "[- TZ:]", "")
    image_name = "${var.image_prefix}-ubuntu-${local.timestamp}"
}

source "azure-arm" "ubuntu"{
    os_type                    = "Linux"
    build_resource_group_name  = "RitterTest_group"
    vm_size                    = "Standard_DS1_v2"
    
    # Source image
    image_publisher = "Canonical"
    image_offer     = "UbuntuServer"
    image_sku       = "16.04.0-LTS"
    image_version   = "latest"
    
    # Destination image
    managed_image_name                 = local.image_name
    managed_image_resource_group_name  = "RitterTest_group"
    
    shared_image_gallery_destination {
    subscription    = "56e8220d-eb98-453d-af39-4409a541a96f"
    resource_group  = "RitterTest_group"
    gallery_name    = "Ritter_Images"
    image_name      = "UbuntuServer_16.04.0-LTS_Ritter"
    image_version   = formatdate("YYYY.MMDD.hhMM",timestamp())
    }
   


    # Spot instance settings
    spot {
        eviction_policy = "Delete"
        max_price       = "0.4"
    }


    # Authentication type
    use_azure_cli_auth = true

}

build{
    sources = ["source.azure-arm.ubuntu"]


    provisioner "shell"{
        
        #installs Docker, Kuberenetes, and Dynatrace 
        #script = "./script.sh"
    

        #Deprovisions the server
        execute_command = "chmod +x {{ .Path }}; {{ .Vars }} sudo -E sh '{{ .Path }}'"
        
        inline = [
        "/usr/sbin/waagent -force -deprovision+user && export HISTSIZE=0 && sync"
        ]
        
        inline_shebang = "/bin/sh -x"
    }

}


