terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.32.0"
    }
  }
  backend "azurerm" {
    # resource_group_name  = "rg-frc-dev-ketan-state-01"
    # storage_account_name = "strgtfstatedev01"
    # container_name       = "rg-frc-dev-container-01"
    # key                  = "dev-todoapp.terraform.tfstate"

  }
}

provider "azurerm" {
  # Configuration options
  features {}
  subscription_id = "98473d5b-c639-404e-9bf2-91559fe65ff8"
}