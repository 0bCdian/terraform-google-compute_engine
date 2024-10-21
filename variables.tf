variable "region_name" {
    type = string
    description = "default is us-central1"
    default = "us-central1"
}

variable "vm_service_account" {
    type = string
    default = "942147123973-compute@developer.gserviceaccount.com"
}
