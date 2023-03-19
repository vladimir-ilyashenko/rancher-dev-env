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

output "instance_ip" {
  value = module.vpn.instance_ip
}
