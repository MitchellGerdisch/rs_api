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
-d start_at=2000-11-05T00:00:00+00:00 \
-d end_at=2016-12-10T00:00:00+00:00 \
-d filter='{"resource_name":["n1-standard-4"],"cloud_href":["/api/clouds/2175"],"datacenter_name":["us-east1-b"],"platform":["Linux/UNIX"],"platform_version":[null],"purchase_option_type":["on_demand_instance"]}'
#AWS: -d filter='{"resource_name":["m3.xlarge"],"cloud_href":["/api/clouds/1"],"platform":["Linux/UNIX"],"platform_version":[null],"purchase_option_type":["on_demand_instance"]}'
#AZURE -d filter='{"resource_name":["D3%20v2"],"cloud_href":["/api/clouds/3523"],"platform":["Linux/UNIX"],"platform_version":[null],"purchase_option_type":["on_demand_instance"]}'
#-d filter='{"resource_name":["m3.xlarge"],"cloud_href":["/api/clouds/1"]}'




