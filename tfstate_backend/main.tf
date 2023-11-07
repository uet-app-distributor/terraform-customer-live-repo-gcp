resource "random_id" "suffix" {
  byte_length = 8
}

resource "google_storage_bucket" "backend" {
  name                     = "uad-customer-terraform-state-${random_id.suffix.hex}"
  location                 = "ASIA"
  public_access_prevention = "enforced"
}
