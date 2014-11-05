#!/bin/sh

if [ $# -ne 2 ] 
then
	echo "USAGE: $0 SHARD ACCOUNTNUM"
	echo "Where SHARD is 3 or 4 representing the SS shard to connect to."
	echo "Where ACCOUNTNUM is the Account Number"
	exit 1
fi

shard=${1}
cloud_id=${2}
echo "cloud_id: ${cloud_id}"
base_uri="https://us-${shard}.rightscale.com"

curl -i -b cookies.txt -H 'X-API-VERSION:1.5' \
-X GET \
${base_uri}/api/clouds/${cloud_id}/ip_addresses
