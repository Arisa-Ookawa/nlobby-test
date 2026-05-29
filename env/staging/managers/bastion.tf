module "managers_bastion" {
  source = "./../../../modules/managers/bastion"

  common = {
    project     = var.project
    environment = var.environment
  }

  vpc_id            = data.terraform_remote_state.staging_cores_network.outputs.cores_network_3az.vpc_id
  bastion_subnet_id = data.terraform_remote_state.staging_cores_network.outputs.cores_network_3az.private_subnet_ids[0]

  ami           = "ami-05a03e6058638183d" # NOTE: AmazonLinux2023
  instance_type = "t3.micro"

  root_block_device = {
    volume_type           = "gp3"
    volume_size           = 8
    delete_on_termination = false
  }
}