locals {
  default_vm_service_account = var.vm_service_account
  vm_machines                = jsondecode(file("${path.module}/vm-machines.json"))
  vm_zone                    = "${var.region_name}-a"
}

resource "google_compute_instance" "default" {
  count = length(local.vm_machines)

  name         = local.vm_machines[count.index].name
  machine_type = local.vm_machines[count.index].machine_type
  zone         = local.vm_zone
  tags         = local.vm_machines[count.index].tags

  boot_disk {
    initialize_params {
      size  = local.vm_machines[count.index].boot_disk_size
      image = local.vm_machines[count.index].image
    }
  }
  labels = {
    my_label = "terraform-machine"
  }

  network_interface {
    network = "default"
    access_config {
      // Configuration for access config
    }
  }

  metadata_startup_script = file("${path.module}/startup-script")

  service_account {
    email  = local.default_vm_service_account
    scopes = ["cloud-platform"]
  }
}
