# Create container for SL VPN

## Build image

sudo docker build -t sl_vpn_centos6 --file Dockerfile_centos6_sl_vpn .

## Create and run the container

sudo docker run -itd --name centos6_sl_vpn --restart unless-stopped --device /dev/net/tun --cap-add=NET_ADMIN sl_vpn_centos6:latest /bin/bash

## Connect to the created container

sudo docker attach centos6_sl_vpn

## Once connected to the container you will be able to use the scripts:

### To connecto to the VPN

Connection.sh ocervant.278462 'Mypassword' 

### To close the VPN connection

CloseVPN.sh

## Execute the Connection.sh script to connect to the VPN inside the container, it will create the VPN connection on the container, you must be attached to the container to use it

sudo docker exec centos6_sl_vpn /bin/sh -c "Connection.sh dstadmin-vpn.ibm278462.12 'h/VPf1Lhl'" & 
