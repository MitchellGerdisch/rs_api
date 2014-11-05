#!/bin/sh

if [ $# -ne 1 ] 
then
	echo "USAGE: $0 SHARD" 
	echo "Where SHARD is 3 or 4 representing the SS shard to connect to."
	exit 1
fi

shard=${1}
base_uri="us-${shard}.rightscale.com"

curl -i -b cookies.txt -H 'X-API-VERSION:1.5' \
https://${base_uri}/api/servers.json |
python -m json.tool
