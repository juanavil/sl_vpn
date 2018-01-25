#!/bin/sh 


USERNAME=$1
PASSWORD=$2
#./get_sl_pass2.sh ocervant@mx1.ibm.com polka673 IBM620265,aep-sas02-spss.naac.sl.edst.ibm.com,620265
SERVERS=$3

BASE_URL="https://slidrs.dst.ibm.com"
DEFAULT_HEADERS=''
COOKIES_FILE="_slidrs_cookies.txt"

ARRAY_VPNC64=/root/slidrs/sl

ACCOUNT_DIR="pass"
mkdir -p $ACCOUNT_DIR
ACCOUNT=$(echo $3 | awk -F, '{print $1}')
ACCOUNT_FILE="$ACCOUNT_DIR/${ACCOUNT}.pass"

if [ ! -f $ACCOUNT_FILE ]; then
	rm  -f $COOKIES_FILE

	echo "GETTING SLIDERS PASSWD ..."
	curl -s "${BASE_URL}/login" -H 'Accept-Encoding: gzip, deflate, sdch' -H 'Accept-Language: en-US,en;q=0.8' -H 'Upgrade-Insecure-Requests: 1' -H 'User-Agent: Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/50.0.2661.102 Safari/537.36' -H 'Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8' -H 'Connection: keep-alive' --compressed --insecure -c $COOKIES_FILE > _log.txt

	curl -s "${BASE_URL}/login" -H 'Accept-Encoding: gzip, deflate, sdch' -H 'Accept-Language: en-US,en;q=0.8' -H 'Upgrade-Insecure-Requests: 1' -H 'User-Agent: Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/50.0.2661.102 Safari/537.36' -H 'Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8' -H 'Connection: keep-alive' --compressed --insecure -c $COOKIES_FILE -b $COOKIES_FILE -X POST --form "ibm_username=${USERNAME}" --form "ibm_password=${PASSWORD}" >> log.txt

	curl -s "${BASE_URL}/slidrs/reserve_id" -H 'Accept-Encoding: gzip, deflate, sdch' -H 'Accept-Language: en-US,en;q=0.8' -H 'Upgrade-Insecure-Requests: 1' -H 'User-Agent: Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/50.0.2661.102 Safari/537.36' -H 'Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8' -H 'Connection: keep-alive' --compressed --insecure -c $COOKIES_FILE -b $COOKIES_FILE >> _log.txt

	curl -s "${BASE_URL}/slidrs/reserve_id_step1" -H 'Accept-Encoding: gzip, deflate, sdch' -H 'Accept-Language: en-US,en;q=0.8' -H 'Upgrade-Insecure-Requests: 1' -H 'User-Agent: Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/50.0.2661.102 Safari/537.36' -H 'Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8' -H 'Connection: keep-alive' --compressed --insecure -c $COOKIES_FILE -b $COOKIES_FILE -X POST --form "servers1[]=${SERVERS}" --form "accounts1=Select Account" >> _log.txt

	curl -s "${BASE_URL}/slidrs/reserve_id_step3" -H 'Accept-Encoding: gzip, deflate, sdch' -H 'Accept-Language: en-US,en;q=0.8' -H 'Upgrade-Insecure-Requests: 1' -H 'User-Agent: Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/50.0.2661.102 Safari/537.36' -H 'Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8' -H 'Connection: keep-alive' --compressed --insecure -c $COOKIES_FILE -b $COOKIES_FILE -X POST --form "subnets=" --form "ticketlist=" --form "time_period=8" --form "reason=Server Issues" --form "ticket_input=" --form "ticketlink=" -i -L > $ACCOUNT_FILE
fi

SL_USERNAME=`cat $ACCOUNT_FILE  | grep -E "Username:" | sed -r 's/^.+value="([^"]+)".+$/\1/'`
SL_PASSWORD=`cat $ACCOUNT_FILE  | grep -E "Password:" | grep Hide | sed -r 's/^.+value="([^"]+)".+$/\1/'`


echo $SL_USERNAME "$SL_PASSWORD"

