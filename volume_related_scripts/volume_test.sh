#!/bin/sh


ZONE_HREF=${1}
SNAPSHOT_ID=${2}
cloud_num="1"

#RS_SELF_HREF=$(rsc --rl10 cm15 --x1 ':has(.rel:val("self")).href' index_instance_session /api/sessions/instance)
#ZONE_HREF=$(rsc --rl10 cm15 --x1 ':has(.rel:val("datacenter")).href' index_instance_session /api/sessions/instance)
SNAPSHOT_HREF=`rsc cm15 --x1 ':has(.rel:val("self")).href' index /api/clouds/1/volume_snapshots "filter[]=resource_uid==$SNAPSHOT_ID"`

rsc --pp cm15 create /api/clouds/${cloud_num}/volumes "volume[name]=MitchTestVolume" "volume[size]=10" "volume[datacenter_href]=${ZONE_HREF}" "volume[parent_volume_snapshot_href]=${SNAPSHOT_HREF}"

VOL_HREF=`rsc cm15 --x1 ':has(.rel:val("self")).href' index /api/clouds/1/volumes "filter[]=parent_volume_snapshot_href==$SNAPSHOT_HREF"`

echo "volume_href: ${VOL_HREF}"
