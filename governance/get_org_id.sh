#!/bin/sh

if [ $# -ne 4 ] 
then
	echo "USAGE: $0 API_HOST REFRESH_TOKEN ACCOUNT_NUM ORG_NAME"
	echo "Where API_HOST is us-3.rightscale.com or us-4.rightscale.com"
	echo "Where ACCESS_TOKEN is the access token obtained during API 1.5 authentication"
	echo "Where ACCOUNT_NUM is the number for the account in which you are launching the application."
	echo "Where ORG_NAME is the name of the org you want the ID for."
	exit 1
fi

api_host=${1}
refresh_token=${2}
accountnum=${3}
org_name=${4}

# First get my user ID
# Sometimes it's just easiest to use rsc
user_id=`rsc --pp -h "${api_host}" -a ${accountnum} -r ${refresh_token} cm15 index /api/sessions "view=whoami" | 
grep "users" |
cut -d ":" -f2 |
cut -d "/" -f4 | 
sed 's/",//g'`

# Get an access token for the governance calls
api_endpoint="https://${api_host}/api/oauth2"
access_token=`../oauth_based/get_access_token.sh ${api_endpoint} ${refresh_token}`

# Now get the specific org with the given name
org=`curl  -s \
     -H "Authorization: Bearer ${access_token}" \
     -H 'X-API-VERSION:1.0' \
     -X GET \
"https://governance.rightscale.com/grs/users/${user_id}/orgs" | 
jq ".[] | select(.name==\"${org_name}\") | .href" |
cut -d "/" -f4 |
sed 's/"//g'`

echo ${org}
