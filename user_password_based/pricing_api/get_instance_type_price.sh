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
-d filter='{"resource_name":["t1.micro"],"cloud_href":["/api/clouds/1"]}'



