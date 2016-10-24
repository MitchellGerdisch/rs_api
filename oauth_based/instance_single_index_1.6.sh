#!/bin/sh

if [ $# -ne 4 ] 
then
	echo "USAGE: $0 ACCOUNT_ID API_ENDPOINT REFRESH_TOKEN INSTANCE_HREF"  
	echo "Where ACCOUNT_ID is the account number."
	echo "Where API_ENDPOINT is your API 1.5 endpoint found in the CM portal."
	echo "Where REFRESH_TOKEN is your refresh token found in the CM portal."
	echo "Where INSTANCE_HREF is the HREF (e.g. /api/clouds/3/instances/EG2KP65I43K5) for the instance you want to look at."
	exit 1
fi

my_account_id=${1}
my_token_endpoint=${2}
my_refresh_token=${3}
my_instance_id=${4}
base_uri=`echo ${my_token_endpoint} | cut -d"/" -f1,2,3`
tmpfile="./$0.tmp"

curl --include \
  -H "X-API-Version:1.5" \
  --request POST "$my_token_endpoint" \
  -d "grant_type=refresh_token" \
  -d "refresh_token=$my_refresh_token"  |
sed 's/,/\
/g' > $tmpfile

access_token=`grep "access_token" $tmpfile |
cut -d":" -f2 |
sed 's/}//g' |
sed 's/\"//g'` 

rm $tmpfile

curl --include \
     -H "X-API-Version:1.6" \
     -H "Authorization: Bearer $access_token" \
     -H "X-Account:${my_account_id}" \
     -X GET "${base_uri}${my_instance_id}"


