#!/bin/sh

if [ $# -ne 1 ]
then
	echo "USAGE: $0 CLOUDAPP_NAME"
	exit
fi

cloudapp_name=${1}

rsc --pp --x1 ":has(.name:val(\"${cloudapp_name}\")) > .deployment" ss index  manager/projects/81332/executions
