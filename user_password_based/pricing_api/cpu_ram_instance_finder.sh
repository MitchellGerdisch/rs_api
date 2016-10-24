
if [ $# -ne 2 ]
then
	echo "USAGE: $0 NUMBER_CPUS AMOUNT_RAM"
	exit 1
fi

echo ""
curl -sG https://pricing.rightscale.com/api/prices -H X-Api-Version:1.0 -H Content-Type:application/json -b cookies.txt \
-d filter="{\"cloud_href\":[\"/api/clouds/1\"],\"cpu_count\":[\"2\",\"3\",\"4\"],\"resource_type\":[\"instance\"],\"purchase_option_type\":[\"on_demand_instance\"],\"platform\":[\"Linux/UNIX\"],\"platform_version\":["null"]}" 

#,\"/api/clouds/2\",\"/api/clouds/6\",\"/api/clouds/7\",\"/api/clouds/3\",\"/api/clouds/5\",\"/api/clouds/4\",\"/api/clouds/9\",\"/api/clouds/8\",\"/api/clouds/2179\",\"/api/clouds/2175\"],
#-d filter="{\"purchase_option_type\":[\"on_demand_instance\"],\"platform\":[\"Linux/UNIX\"],\"platform_version\":[null],\"cpu_count\":[\"$1\"],\"memory\":[\"$2\"]}"

#,"datacenter_name":[null]}'

echo ""
