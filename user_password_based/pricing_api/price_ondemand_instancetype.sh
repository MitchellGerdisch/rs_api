# Assumes authentication script was run and created the cookies.txt file

if [ $# -ne 1 ]
then
	echo "USAGE: $0 INSTANCE_TYPE"
	echo "INSTANCE_TYPE is m1.small, etc"
	exit 1
fi

instance_type=${1}

curl -G https://pricing.rightscale.com/api/prices \
-H X-Api-Version:1.0 \
-H Content-Type:application/json \
-b cookies.txt \
-d filter="{\"cloud_href\":[\"/api/clouds/1\"],\"resource_type\":[\"instance\"],\"resource_name\":[\"${instance_type}\"],\"purchase_option_type\":[\"on_demand_instance\"]}" \
-d limit=1 


