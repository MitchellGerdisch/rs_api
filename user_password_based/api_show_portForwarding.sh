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
base_uri="https://us-${shard}.rightscale.com"

instance_href=`curl -i -b cookies.txt -H 'X-API-VERSION:1.5' \
-X GET ${base_uri}/api/servers/${servernum}.xml  |
grep current_instance | 
cut -d"=" -f3 | 
sed 's/\"//g' | 
sed 's/\/>//g'`

# NOTE: instance_href includes the leading slash so don't add slash after the URI
curl -v -i -b cookies.txt -H 'X-API-VERSION:1.5' \
-X GET ${base_uri}${instance_href}/public_ip_addresses.xml
