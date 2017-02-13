if [ $# -ne 1 ]
then
	echo "USAGE: $0 SESSIONTOKEN" 
	exit 2
fi

AUTHTOKEN=${1}

echo ""
curl -sG https://pricing.rightscale.com/api/prices \
-H X-Api-Version:1.0 \
-H Content-Type:application/json \
-H "Authorization: Bearer ${AUTHTOKEN}" \
-d start_at=2016-11-05T00:00:00+00:00 \
-d filter='{"resource_name":["m3.xlarge"],"cloud_href":["/api/clouds/1"]}'
#-d filter='{"resource_name":["m3.xlarge"],"cloud_href":["/api/clouds/1"], "start_at":2016-11-05T00:00:00+00:00}'
#-d filter='{"resource_name":["m3.xlarge"],"cloud_href":["/api/clouds/1"]}'




