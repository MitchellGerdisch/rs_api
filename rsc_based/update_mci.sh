#!/bin/sh

if [ $# -ne 2 ]
then
	echo "USAGE: $0 IMAGE_HREF CLOUD_HREF"
	echo "Where IMAGE_HREF is the HREF of the image. Can be found by drilling down in Cloud Management: Clouds -> Images."
	echo "Where CLOUD_HREF is the HREF for the given cloud. E.g. /api/clouds/1 for AWS US-East."
	exit 1
fi

IMAGE_HREF=${1} # One can find the Image HREF based on the image name using the images API calls. I'm just being lazy.
CLOUD_HREF=${2} # One can find the Cloud HREF based on the cloud name using the clouds API calls. I'm just being lazy.

rsc -a

