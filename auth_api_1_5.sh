#!/bin/sh

if [ $# -ne 2 ] 
then
	echo "USAGE: $0 SHARD ACCOUNT_NUM" 
	echo "Where SHARD is 3 or 4 representing the SS shard to connect to."
	echo "Where ACCOUNT_NUM is the number for the account in which you are launching the application."
	exit 1
fi

shard=${1}
accountnum=${2}

curl -i -c cookies.txt -H 'X-API-VERSION:1.5' -d email="${email}" -d password="${password}" https://us-${shard}.rightscale.com/api/sessions -d account_href="/api/accounts/${accountnum}"
