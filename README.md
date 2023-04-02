# Deploy dev env

1. Execute terraform to create rsa key
```
cd vpn
terraform init
terraform apply -target=local_file.id_rsa
terraform apply -target=local_file.id_rsa_pub
```

2. Update module code to disable source/destination check on VPN server (this is crucial to route traffic between rancher and nodes)
```
sed -i '/^resource "aws_instance/a source_dest_check = false' .terraform/modules/vpn/main.tf
```

3. Execute terraform
```
terraform apply
```

4. Login to vpn server copy client config
```
ssh -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null -i id_rsa ubuntu@<instance_ip> "sudo cat /root/ilyashenko.ovpn" > config.ovpn
```

5. Connect to VPN
```
openvpn --config config.ovpn
```

6. Start rancher
```
sudo docker-compose up -d
```

7. Configure rancher at [https://localhost](https://localhost), set Server URL to `https://<your_vpn_ip>` (default is 10.8.0.3)

8. Create new cluster RKE2/Custom at [Cluster Management](https://localhost/dashboard/c/_/manager/provisioning.cattle.io.cluster). Make sure to create node pool in same availability zone and network as vpn instance (found in terraform output)


# Stop/Start VPN instance
```
aws ec2 stop-instances --instance-ids <instance_id>
aws ec2 start-instances --instance-ids <instance_id>
```
