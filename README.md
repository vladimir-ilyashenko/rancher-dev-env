## Configure openvpn server
1. Execute terraform to create rsa key
    ```
    terraform init
    terraform apply -target=local_file.id_rsa
    terraform apply -target=local_file.id_rsa_pub
    ```
2. Execute terraform
    ```
    terraform apply
    ```
3. Login to vpn server copy client config
    ```
    ssh -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null -i id_rsa ubuntu@<instance_ip> "sudo cat /root/ilyashenko.ovpn" > config.ovpn
    ```
4. Connect to VPN
    ```
    openvpn --config config.ovpn
    ```
