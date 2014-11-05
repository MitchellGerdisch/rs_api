#!/bin/sh


if [ $# -ne 2 ] 
then
	echo "USAGE: $0 SS_SHARD ACCOUNT_NUM"
	echo "Where SS_SHARD is 3 or 4 representing the SS shard to connect to."
	echo "Where ACCOUNT_NUM is the number for the account in which you are launching the application."
	exit 1
fi

echo "THIS SCRIPT IS FAR FROM PERFECT"
echo "Dumps all sorts of stuff you need to scour to find the execution ID."
echo "TO-DO: Add some parsing of the output to make it easier to find the execution ID."
echo ""
echo ""

ss_shard=${1}
accountnum=${2}
filter=${3}

curl -i -b cookies.txt -H 'X-API-VERSION:1.0' \
-X GET https://selfservice-${ss_shard}.rightscale.com/api/manager/projects/${accountnum}/operations |
grep "\[{" |
python -m json.tool
