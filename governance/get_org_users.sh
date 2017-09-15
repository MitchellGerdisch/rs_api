#!/bin/sh

if [ $# -ne 4 ] 
then
	echo "USAGE: $0 API_ENDPOINT REFRESH_TOKEN ORG_NUMBER EMAIL_REGEXP"
	echo "Where API_ENDPOINT is your auth URL for the account."
	echo "Where ACCESS_TOKEN is the access token obtained during API 1.5 authentication"
	echo "Where ORG_NUMBER is the ID of the organization"
	echo "Where EMAIL_REGEXP is a regular expression to match on the users' email addresses."
	exit 1
fi

api_endpoint=${1}
refresh_token=${2}
orgnum=${3}
regexp=${4}

# Get an access token for the governance calls
access_token=`../oauth_based/get_access_token.sh ${api_endpoint} ${refresh_token}`

# Now get my list of orgs
curl -s \
     -H "Authorization: Bearer ${access_token}" \
     -H 'X-API-VERSION:2.0' \
     -X GET \
"https://governance.rightscale.com/grs/orgs/${orgnum}/users" | jq ".[] | select(.email | match(\"(${regexp})\")) | {(.email): .href}" |
grep ":" |
sed 's/  *//g' |
sed 's/"//g'

