#!/usr/bin/python

import sys
import requests
import json

if len(sys.argv) != 3:
	print "USAGE: ",sys.argv[0]," SESSION_TOKEN INSTANCE_TYPE_NAME"
	sys.exit()


AUTHTOKEN = sys.argv[1]
INSTANCE_TYPE = sys.argv[2]

headers = {
    'X-Api-Version': '1.0',
    'Content-Type': 'application/json',
    'Authorization': 'Bearer '+AUTHTOKEN,
}

data = {
  'start_at': '2008-11-05T00:00:00 00:00',
  'end_at': '2016-12-10T00:00:00 00:00'
  #'filter': '{"resource_name":["m3.xlarge"],"cloud_href":["/api/clouds/1"],"platform":["Linux/UNIX"],"platform_version":[null],"purchase_option_type":["on_demand_instance"]}'
}


r = requests.get('https://pricing.rightscale.com/api/prices', headers=json.dumps(headers), data=json.dumps(data))

print r.json()



#if [ $# -ne 1 ]
#then
#	echo "USAGE: $0 SESSIONTOKEN" 
#	exit 2
#fi
#
#AUTHTOKEN=${1}
#
#echo ""
#curl -sG https://pricing.rightscale.com/api/prices \
#-H X-Api-Version:1.0 \
#-H Content-Type:application/json \
#-H "Authorization: Bearer ${AUTHTOKEN}" \
#-d start_at=2008-11-05T00:00:00+00:00 \
#-d end_at=2016-12-10T00:00:00+00:00 \
#-d filter='{"resource_name":["m3.xlarge"],"cloud_href":["/api/clouds/1"],"platform":["Linux/UNIX"],"platform_version":[null],"purchase_option_type":["on_demand_instance"]}'
##-d filter='{"resource_name":["m3.xlarge"],"cloud_href":["/api/clouds/1"], "start_at":2016-11-05T00:00:00+00:00}'
##-d filter='{"resource_name":["m3.xlarge"],"cloud_href":["/api/clouds/1"]}'
#
#
#
#
