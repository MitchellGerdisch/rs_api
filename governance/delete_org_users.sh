#!/bin/sh

if [ $# -ne 4 ] 
then
	echo "USAGE: $0 API_HOST REFRESH_TOKEN ORG_NUMBER EMAIL_REGEXP"
	echo "Where API_HOST is us-3.rightscale.com or us-4.rightscale.com."
	echo "Where ACCESS_TOKEN is the access token obtained during API 1.5 authentication"
	echo "Where ORG_NUMBER is the ID of the organization"
	echo "Where EMAIL_REGEXP is a regular expression to match on the users' email addresses."
	exit 1
fi

api_host=${1}
api_endpoint="https://${api_host}/api/oauth2"
refresh_token=${2}
orgnum=${3}
regexp=${4}

tmpfile="./$0.tmp"

./get_org_users.sh ${api_endpoint} ${refresh_token} ${orgnum} ${regexp}  > ${tmpfile}

access_token=`../oauth_based/get_access_token.sh ${api_endpoint} ${refresh_token}`

for orguser in $(cat ${tmpfile})
do
	user_email=`echo ${orguser} | cut -d":" -f1`
	user_id=`echo ${orguser} | cut -d":" -f2 | cut -d"/" -f4`
	
	#echo "EMAIL: ${user_email}; USER ID: ${user_id}"
	#echo "Do you want to delete ####  ${user_email} ####? (y/n)"
	#read resp
	#if [ ${resp} == "y" ]
	#then
		echo "Deleting ${user_email}"

		curl -s \
     				-H "Authorization: Bearer ${access_token}" \
     				-H 'X-API-VERSION:2.0' \
     				-X DELETE\
				"https://governance.rightscale.com/grs/orgs/${orgnum}/users/${user_id}"


	#fi

done 

rm ${tmpfile}
