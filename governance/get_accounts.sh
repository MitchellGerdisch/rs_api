#!/bin/sh

if [ $# -ne 3 ] 
then
	echo "USAGE: $0 API_ENDPOINT REFRESH_TOKEN ACCOUNT_NUM"
	echo "Where API_ENDPOINT is your auth URL for the account."
	echo "Where ACCESS_TOKEN is the access token obtained during API 1.5 authentication"
	echo "Where ACCOUNT_NUM is the number for the account in which you are launching the application."
	exit 1
fi

api_endpoint=${1}
refresh_token=${2}
accountnum=${3}

# Get an access token for the governance calls
access_token=`../oauth_based/get_access_token.sh ${api_endpoint} ${refresh_token}`

echo ${user_id}
echo ${access_token}

# Now get my list of orgs
curl -v -i \
     -H "Authorization: Bearer ${access_token}" \
     -H 'X-API-VERSION:1.0' \
     -X GET \
"https://governance.rightscale.com/grs/projects"

