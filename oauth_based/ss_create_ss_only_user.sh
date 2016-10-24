#!/bin/sh

if [ $# -ne 4 ] 
then
	echo "USAGE: $0 SS_SHARD ACCOUNT_NUM USER_ID ACCESS_TOKEN" 
	echo "Where SS_SHARD is 3 or 4 representing the SS shard to connect to."
	echo "Where ACCOUNT_NUM is the number for the account in which you are launching the application."
	echo "Where USER_ID is the number in the given user's href."
	echo "Where ACCESS_TOKEN is the cm15 auth token."
	exit 1
fi

ss_shard=${1}
accountnum=${2}
user_id=${3}
access_token=${4}

echo "Adding user, $user_id, as SS only user."
echo "Hit enter to continue or ctl-c to exit."
read goo

curl -v -i \
     -H "Authorization: Bearer ${access_token}" \
     -H 'X-API-VERSION:1.0' \
     -X POST \
     https://selfservice-${ss_shard}.rightscale.com/api/catalog/accounts/${accountnum}/end_users \
	-d user_ids=[\"${user_id}\"]


