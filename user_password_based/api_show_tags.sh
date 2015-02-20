#!/bin/sh

if [ $# -ne 1 ] 
then
	echo "USAGE: $0 SHARD"
	echo "Where SHARD is 3 or 4 representing the SS shard to connect to."
	exit 1
fi

shard=${1}
base_uri="https://us-${shard}.rightscale.com"

curl --verbose -i -b cookies.txt -H 'X-API-VERSION:1.5' \
-X POST \
-d resource_type=instances \
-d tags[]=database:active=true \
-d tags[]=rs_monitoring:state=active \
-d match_all=false \
${base_uri}/api/tags/by_tag.xml

