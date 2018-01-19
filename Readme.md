# Create container for SL VPN

## Build image

sudo docker build -t sl_vpn_centos6 --file Dockerfile_centos6_sl_vpn .

## Create container

sudo docker run -itd --name centos6_sl_vpn --restart unless-stopped --device /dev/net/tun --cap-add=NET_ADMIN sl_vpn_centos6:latest /bin/bash

## Connect to the created container

sudo docker attach centos6_sl_vpn