#!/bin/sh

if [ $# -ne 3 ] 
then
	echo "USAGE: $0 API_HOST REFRESH_TOKEN ACCOUNT_NUM"
	echo "Where API_HOST is your the API host (us-3.rightscale.com or us-4.rightscale)."
	echo "Where ACCESS_TOKEN is the access token obtained during API 1.5 authentication"
	echo "Where ACCOUNT_NUM is the number for the account in which you are launching the application."
	exit 1
fi

api_host==${1}
refresh_token=${2}
accountnum=${3}

# First get my user ID
# Sometimes it's just easiest to use rsc
user_id=`rsc --pp -h ${api_host} -a ${accountnum} -r ${refresh_token} cm15 index /api/sessions "view=whoami" | 
grep "users" |
cut -d ":" -f2 |
cut -d "/" -f4 | 
sed 's/",//g'`

# Get an access token for the governance calls
api_endpoint="https://${api_host}/api/oauth2"
access_token=`../oauth_based/get_access_token.sh ${api_endpoint} ${refresh_token}`

echo ${user_id}
echo ${access_token}

# Now get my list of orgs
curl -v -i \
     -H "Authorization: Bearer ${access_token}" \
     -H 'X-API-VERSION:1.0' \
     -X GET \
"https://governance.rightscale.com/grs/users/${user_id}/orgs"

