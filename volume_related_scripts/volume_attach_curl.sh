#!/bin/sh

if [ $# -ne 2 ] 
then
	echo "USAGE: $0 API_ENDPOINT REFRESH_TOKEN"  
	echo "Where API_ENDPOINT is your API 1.5 endpoint found in the CM portal."
	echo "Where REFRESH_TOKEN is your refresh token found in the CM portal."
	exit 1
fi


echo "YOU need to set variables in the script for the volume attachment."
echo "If you have done that, hit return"
read resp

#### THESE ARE THE THINGS YOU NEED TO SET ####
cloudNumber=1
cpShareVolumeHref="/api/clouds/1/volumes/FDFT87ORGPBV"   # Mitch_volume_test
irInstanceHref="/api/clouds/1/instances/AQDI17PD04M30" # Volume Testing
cpShareVolumeDeviceName="/dev/sdf"
####


my_token_endpoint=${1}
my_refresh_token=${2}
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
     -H "X-API-Version:1.5" \
     -H "Authorization: Bearer $access_token" \
     -X POST "${base_uri}/api/clouds/$cloudNumber/volume_attachments" \
     -d volume_attachment[volume_href]=$cpShareVolumeHref \
	-d volume_attachment[instance_href]=$irInstanceHref \
	-d volume_attachment[device]=$cpShareVolumeDeviceName \
	-d volume_attachment[settings][delete_on_termination]=true


