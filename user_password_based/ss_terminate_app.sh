#!/bin/sh

if [ $# -ne 3 ] 
then
	echo "USAGE: $0 SS_SHARD ACCOUNT_NUM EXECUTION_ID"
	echo "Where SS_SHARD is 3 or 4 representing the SS shard to connect to."
	echo "Where ACCOUNT_NUM is the number for the account in which you are launching the application."
	echo "Where EXECUTION_ID is the execution ID of the running app."
	exit 1
fi

ss_shard=${1}
accountnum=${2}
execution_id=${3}

echo "Terminating application with execution ID ${execution_id}." 
echo "Hit enter to continue or ctl-c to exit."
read goo

curl -i -b cookies.txt -H 'X-API-VERSION:1.0' \
-X POST https://selfservice-${ss_shard}.rightscale.com/api/manager/projects/${accountnum}/operations \
-d name="terminate" \
-d execution_id="${execution_id}"
