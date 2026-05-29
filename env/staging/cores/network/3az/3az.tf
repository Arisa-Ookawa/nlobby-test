module "cores_network_3az" {
  source = "../../../../../modules/cores/network/3az"

  common = {
    project     = var.project
    environment = var.environment
  }

  vpc_cidr = "172.35.0.0/21"

  public_az1_cidr = "172.35.0.0/25"
  public_az2_cidr = "172.35.0.128/25"
  public_az3_cidr = "172.35.1.0/25"

  private_az1_cidr = "172.35.3.0/25"
  private_az2_cidr = "172.35.3.128/25"
  private_az3_cidr = "172.35.4.0/25"

  lattice_resource_configuration = {
    type                                           = "SINGLE"
    protocol                                       = "TCP"
    allow_association_to_shareable_service_network = true
    domain_name                                    = "tmp-test-ao.dw-ed.com"
    ip_address_type                                = "IPV4"
  }
}
