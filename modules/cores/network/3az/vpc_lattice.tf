/**
# VPC Lattice resource gateway
*/
resource "aws_vpclattice_resource_gateway" "this" {
  name   = "${var.common.project}-${var.common.environment}-resource-gw-${var.sfx}"
  vpc_id = aws_vpc.this.id
  subnet_ids = [
    aws_subnet.private_az1.id,
    aws_subnet.private_az2.id
  ]
  security_group_ids = [
    aws_security_group.vpc_lattice.id
  ]

  tags = {
    Name        = "${var.common.project}-${var.common.environment}-resource-gw-${var.sfx}"
    Environment = var.common.environment
    Createdby   = "Terraform"
  }
}

/**
# VPC Lattice configuration
*/
resource "aws_vpclattice_resource_configuration" "this" {
  name                                           = "${var.common.project}-${var.common.environment}-configuration-${var.sfx}"
  type                                           = var.lattice_resource_configuration.type
  protocol                                       = var.lattice_resource_configuration.protocol
  port_ranges                                    = [443]
  resource_gateway_identifier                    = aws_vpclattice_resource_gateway.this.id
  allow_association_to_shareable_service_network = var.lattice_resource_configuration.allow_association_to_shareable_service_network
  resource_configuration_definition {
    dns_resource {
      domain_name     = var.lattice_resource_configuration.domain_name
      ip_address_type = var.lattice_resource_configuration.ip_address_type
    }
  }

  tags = {
    Name        = "${var.common.project}-${var.common.environment}-configuration-${var.sfx}"
    Environment = var.common.environment
    Createdby   = "Terraform"
  }
}