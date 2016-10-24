#!/bin/sh

if [ $# -ne 6 ] 
then
	echo "USAGE: $0 SS_SHARD ACCOUNT_NUM DEPLOYED_APP_NAME WEBTEXT APPLICATION_HREF ACCESS_TOKEN"
	echo "Where SS_SHARD is 3 or 4 representing the SS shard to connect to."
	echo "Where ACCOUNT_NUM is the number for the account in which you are launching the application."
	echo "Where DEPLOYED_APP_NAME is the name you want to give the cloud application once it launches."
	echo "Where WEBTEXT is the webtext parameter input."
	echo "Where APPLICATION_HREF is the href for the application in the catalog."
	echo "Where ACCESS_TOKEN is the access token obtained during API 1.5 authentication"
	exit 1
fi

ss_shard=${1}
accountnum=${2}
cloudapp_name=${3}
webtext=${4}
application_href=${5}
access_token=${6}

echo "Launching application ${cloudapp_name} using catalog item ${application_href} in account ${accountnum}"
echo "Hit enter to continue or ctl-c to exit."
read goo

curl -v -i \
     -H "Authorization: Bearer ${access_token}" \
     -H 'X-API-VERSION:1.0' \
     -X POST \
     https://selfservice-${ss_shard}.rightscale.com/api/catalog/catalogs/${accountnum}/applications/${application_href}/actions/launch  \
	-d name="${cloudapp_name}" \
	-d description="Cloud App deployed via API" \
	-d options="[{\"name\":\"param_webtext\", \"type\":\"string\", \"value\":\"${webtext}\"}]"


