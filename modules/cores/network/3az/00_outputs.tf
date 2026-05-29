/** 
# Outputs
*/
output "vpc_id" {
  value = aws_vpc.this.id
}

output "vpc_lattice_resource_gateway_id" {
  value = aws_vpclattice_resource_gateway.this.id
}

output "vpc_lattice_resource_configuration_arn" {
  value = aws_vpclattice_resource_configuration.this.arn
}

output "public_subnet_ids" {
  value = tolist(
    [
      aws_subnet.public_az1.id,
      aws_subnet.public_az2.id,
      aws_subnet.public_az3.id
    ]
  )
}

output "private_subnet_ids" {
  value = tolist(
    [
      aws_subnet.private_az1.id,
      aws_subnet.private_az2.id,
      aws_subnet.private_az3.id
    ]
  )
}

output "public_subnet_cidr" {
  value = tolist(
    [
      var.public_az1_cidr,
      var.public_az2_cidr,
      var.public_az3_cidr
    ]
  )
}

output "private_subnet_cidr" {
  value = tolist(
    [
      var.private_az1_cidr,
      var.private_az2_cidr,
      var.private_az3_cidr
    ]
  )
}

output "nat_gateway" {
  value = tolist(
    [
      "${aws_eip.nat_gateway_az1.public_ip}/32",
      "${aws_eip.nat_gateway_az2.public_ip}/32",
      "${aws_eip.nat_gateway_az3.public_ip}/32",
    ]
  )
}

output "aws_security_group_vpc_lattice" {
  value = aws_security_group.vpc_lattice
}