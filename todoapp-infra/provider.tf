terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.32.0"
    }
  }
  /*backend "azurerm" {
    resource_group_name  = "ketan-rg"
    storage_account_name = "strgtfstateketan"
    container_name       = "tfstateketan"
    key                  = "ketandevops.terraform.tfstate"

  }*/
}

provider "azurerm" {
  # Configuration options
  features {}
  subscription_id = "98473d5b-c639-404e-9bf2-91559fe65ff8"
}