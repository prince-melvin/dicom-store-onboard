terraform {
  required_providers {
    hsdp = {
      source  = "philips-software/hsdp"
      version = ">= 0.18.2"
    }
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 2.67.0"
    }
  }
  required_version = ">= 1.0"
}