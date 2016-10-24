#!/bin/sh

# Returns

if [ $# -ne 3 ]
then
	echo "USAGE: $0 ACCOUNT_ID AWS_CLOUD_ID AWS_RESOURCE_ID" 
	echo "Where ACCOUNT_ID is the RightScale account ID."
	echo "Where AWS_CLOUD_ID is the RightScale ID number for the given cloud. E.g. 1 for US-East, 3 for US-West."
	echo "Where AWS_RESOURCE_ID is the resource ID as seen in AWS."
	exit 1
fi

ACCOUNT_ID=${1}
AWS_CLOUD_ID=${2}
AWS_RESOURCE_ID=${3}


resource_type=`echo $AWS_RESOURCE_ID | cut -d"-" -f1`

if [ $resource_type == "vol" ]
then
	# VOLUME type
	# Get the href
	volume_href=`rsc -a ${ACCOUNT_ID} --xm ":has(.rel:val(\"self\")).href" cm15 index /api/clouds/${AWS_CLOUD_ID}/volumes "filter[]=resource_uid==${AWS_RESOURCE_ID}" | sed 's/\"//g'`

	echo $volume_href

fi

