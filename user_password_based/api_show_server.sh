#!/bin/sh

if [ $# -ne 2 ] 
then
	echo "USAGE: $0 SHARD SERVER_NUM"
	echo "Where SHARD is 3 or 4 representing the SS shard to connect to."
	echo "Where SERVER_NUM is the number of the server you want to see data for."
	exit 1
fi

shard=${1}
servernum=${2}

curl -i -b cookies.txt -H 'X-API-VERSION:1.5' \
https://us-${shard}.rightscale.com/api/servers/${servernum}.xml 
