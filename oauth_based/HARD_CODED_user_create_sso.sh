#!/bin/sh


my_token_endpoint='https://us-3.rightscale.com/api/oauth2'
my_refresh_token='758f52650ce9c713ae0c9e29fb82be1630c8e3be'

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
     -X POST \
	-d user[email]=samluser3@jesslex.com \
	-d user[company]='My Company' \
	-d user[phone]=1234567890 \
	-d user[first_name]=Mitch \
	-d user[last_name]=Gerdisch \
	-d user[identity_provider_href]='/api/identity_providers/399' \
	-d user[principal_uid]='samluser3@jesslex.com' \
    ${base_uri}/api/users
echo ""
