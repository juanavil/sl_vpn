#!/bin/bash

rand() 
{
	printf $((  $1 *  RANDOM  / 32767   ))
}
rand_element () 
{
    local -a th=("$@")
    unset th[0]
    printf $'%s\n' "${th[$(($(rand "${#th[*]}")+1))]}"
}

site=`rand_element https://vpn.nyc01.softlayer.com https://vpn.sea01.softlayer.com https://vpn.wdc01.softlayer.com https://vpn.hou02.softlayer.com https://vpn.sjc01.softlayer.com https://vpn.den01.softlayer.com https://vpn.lax01.softlayer.com https://vpn.nyc01.softlayer.com`
echo $site
if [ "$#" == "0" ]; then
    echo "No arguments provided"
    echo "Usage:" 
    echo "./Connection.sh <Account> <Password>"
    exit 1
elif [ "$#" == "2" ]; then
    VPNid=$1
    b=$2
    vpn/array_vpnc64 -hostname $site -username $VPNid -passwd $b &
else
    echo "More than 2 arguments provided"
    echo "Usage:" 
    echo "./Connection.sh <Account> <Password>"
fi
