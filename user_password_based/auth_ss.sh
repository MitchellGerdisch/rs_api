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

curl -v -i -b cookies.txt "https://selfservice-${shard}.rightscale.com/api/catalog/new_session?account_id=${accountnum}"
