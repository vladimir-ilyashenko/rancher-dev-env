resource "tls_private_key" "ssh" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "local_file" "id_rsa_pub" {
  filename = "id_rsa.pub"
  content = tls_private_key.ssh.public_key_openssh
}

resource "local_file" "id_rsa" {
  filename = "id_rsa"
  content = tls_private_key.ssh.private_key_openssh
  file_permission = "0600"
}
