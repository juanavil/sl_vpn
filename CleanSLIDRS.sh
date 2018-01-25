#!/usr/bin/env bash

if [ "$#" == "0" ]; then
    echo "No arguments provided, cleaning all accounts cache"
    rm -rf pass/ log.txt _log.txt _slidrs_cookies.txt
    exit 0
elif [ "$#" == "1" ]; then
    echo "One parameter provided, cleaning account cache"
    if [ -f "pass/$1.pass" ]
    then
	    echo "pass/$1.pass found, cleaning cache file"
	    rm -rf pass/$1*
        exit 0
    else
	    echo "pass/$1.pass not found, no cache file exist"
	    exit 1
    fi
else
    echo "Provide one or no arguments"
    echo "Usage: CleanSLIDRS.sh <Account>"
    exit 1
fi



