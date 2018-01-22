# Create container for SL VPN

## Build image

sudo docker build -t sl_vpn_centos6 --file Dockerfile_centos6_sl_vpn .

## Create and run the container

sudo docker run -itd --name centos6_sl_vpn -v /tmp/.X11-unix:/tmp/.X11-unix -e "DISPLAY=unix${DISPLAY}" -e GDK_SCALE -e GDK_DPI_SCALE --device /dev/snd --device /dev/dri --restart unless-stopped --device /dev/net/tun --cap-add=NET_ADMIN sl_vpn_centos6:latest /bin/bash

## Connect to the created container

sudo docker attach centos6_sl_vpn

## Once connected to the container you will be able to use the scripts:

### To connecto to the VPN

Connection.sh ocervant.278462 'Mypassword' 

### To close the VPN connection

CloseVPN.sh

### Execute the Connection.sh script to connect to the VPN inside the container (sometimes this is not working, on these cases just run it from inside the container), it will create the VPN connection on the container, you must be attached to the container to use it

sudo docker exec centos6_sl_vpn /bin/sh -c "Connection.sh dstadmin-vpn.ibm295233.23 '!uy1nEdAC'" & 

### You will be able to run vncviewer and xfreerdp from inside the container 




