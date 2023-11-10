module "network" {
  source = "../Modules/network"
  linux_id = module.instances.linux_id
  client_id = module.instances.client_id
}

module "instances" {
  source                   = "../Modules/instances"
  vpc_id                   = module.network.vpc_id
  subnet_id                = module.network.subnet_id
  linux_security_group_id  = module.security-group.linux_security_group
  client_security_group_id = module.security-group.client_security_group
}

module "security-group" {
  source = "../Modules/security-groups"
  vpc_id = module.network.vpc_id
}