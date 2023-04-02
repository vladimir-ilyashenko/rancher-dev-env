module "vpn" {
      source  = "hadenlabs/openvpn/aws"
      version = "0.4.0"

      public_key = local_file.id_rsa_pub.filename
      private_key = local_file.id_rsa.filename
      admin_user = "ilyashenko"
      storage_path = "./openvpn"
      subnet_cidr_block = "10.120.0.0/16"
      vpc_cidr_block = "10.120.0.0/16"
      name = "rancher-dev"
}

data "aws_subnet" "vpn" {
  id = module.vpn.instance.subnet_id
}

data "aws_vpc" "vpn" {
  id = data.aws_subnet.vpn.vpc_id
}

resource "aws_route" "rancher" {
    destination_cidr_block = "10.8.0.0/24"
    network_interface_id   = module.vpn.instance.primary_network_interface_id
    route_table_id         = data.aws_vpc.vpn.main_route_table_id
}

output "instance_ip" {
  value = module.vpn.instance_ip
}

output "instance_id" {
  value = module.vpn.instance.id
}

output "instance_zone" {
  value = module.vpn.instance.availability_zone
}

output "subnet" {
  value = data.aws_subnet.vpn.id
}
