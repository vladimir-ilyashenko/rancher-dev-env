# Execute terraform to create rsa key
```
terraform init
terraform apply -target=local_file.id_rsa
terraform apply -target=local_file.id_rsa_pub
```

# Execute terraform
```
terraform apply
```

# Login to vpn server copy client config
```
ssh -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null -i id_rsa ubuntu@<instance_ip> "sudo cat /root/ilyashenko.ovpn" > config.ovpn
```

# Connect to VPN
```
openvpn --config config.ovpn
```
