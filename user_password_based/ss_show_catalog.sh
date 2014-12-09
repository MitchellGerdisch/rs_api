#!/bin/sh

if [ $# -ne 2 ] 
then
	echo "USAGE: $0 SS_SHARD ACCOUNT_NUM" 
	echo "Where SS_SHARD is 3 or 4 representing the SS shard to connect to."
	echo "Where ACCOUNT_NUM is the number for the account in which you are launching the application."
	exit 1
fi

ss_shard=${1}
accountnum=${2}

curl -i -b cookies.txt -H 'X-API-VERSION:1.0' "https://selfservice-${ss_shard}.rightscale.com/api/catalog/catalogs/${accountnum}/applications"

