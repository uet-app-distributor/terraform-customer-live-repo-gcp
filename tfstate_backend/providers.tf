terraform {
  required_providers {
    random = {
      source  = "hashicorp/random"
      version = "3.5.1"
    }
    google = {
      source  = "hashicorp/google"
      version = "5.5.0"
    }
  }
}

provider "google" {}