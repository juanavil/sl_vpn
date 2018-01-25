#!/usr/bin/env bash

#TODO: Add arguments checking and automate VPN SLIDRs id gathering

if [ "$#" == "0" ]; then
    echo "No arguments provided"
    echo "Usage: $0 <ACCOUNT>"
    exit 1
elif [ "$#" -gt "1" ]; then
    echo "Function needs only 1 parameter"
    echo "Usage: $0 <ACCOUNT>"
    exit 1
fi 

id=$1 #IBM295233

user_slidr=`grep "User" User_Password.cr | cut -d':' -f2`
pass_slidr=`grep "Password" User_Password.cr | cut -d':' -f2`
./get_sl_pass2_original.sh $user_slidr $pass_slidr $id,$id,$id
slidr_username=`./get_sl_pass2_original.sh $user_slidr $pass_slidr $id,$id,$id | cut -d' ' -f1`
slidr_password=`./get_sl_pass2_original.sh $user_slidr $pass_slidr $id,$id,$id | cut -d' ' -f2`

echo "$slidr_username - $slidr_password"

if [ -z "$slidr_username" ];
then
    echo "Unable to get SLIDR Id, please try again"
    ./CleanSLIDRS.sh $id
    exit 1
fi

tun_device=$id
export vpn_user=$slidr_username #Get from slidrs script $slidrs_username
export vpn_password="$slidr_password" #Get from slidrs script $slidrs_password

sudo mknod /dev/net/tun${tun_device} c 10 200

## Create and run the container

sudo docker run -itd --name centos6_sl_vpn_"$id" -v /tmp/.X11-unix:/tmp/.X11-unix -e vpn_user=$vpn_user -e vpn_password=$vpn_password -e "DISPLAY=unix${DISPLAY}" -e GDK_SCALE -e GDK_DPI_SCALE --device /dev/snd --device /dev/dri --restart unless-stopped --device /dev/net/tun${tun_device} --cap-add=NET_ADMIN sl_vpn_centos6:latest

sudo docker attach centos6_sl_vpn_"$id"
