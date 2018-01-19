vpn=$( pgrep array_vpnc )
if [[ -z $vpn ]];
then
    echo "VPN not running"
else
    kill $vpn
fi

