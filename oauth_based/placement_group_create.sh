#!/bin/sh

if [ $# -ne 4 ] 
then
	echo "USAGE: $0 API_ENDPOINT REFRESH_TOKEN CLOUD_ID PLACEMENT_GROUP_NAME"  
	echo "Where API_ENDPOINT is your API 1.5 endpoint found in the CM portal."
	echo "Where REFRESH_TOKEN is your refresh token found in the CM portal."
	echo "Where CLOUD_ID (i.e. the cloud number in RS) is the ID of the cloud in which you want to create the SSH key."
	echo "Where PLACEMENT_GROUP_NAME is the name of the placement group you want to create."
	exit 1
fi

my_token_endpoint=${1}
my_refresh_token=${2}
cloud_id=${3}
pg_name=${4}

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

curl --verbose --include \
     -H "X-API-Version:1.5" \
     -H "Authorization: Bearer $access_token" \
     -X POST "${base_uri}/api/placement_groups" \
	-d placement_group[name]="${pg_name}" \
	-d placement_group[cloud_href]="/api/clouds/${cloud_id}"

echo ""
