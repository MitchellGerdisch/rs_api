

echo ""
curl -sG https://pricing.rightscale.com/api/prices -H X-Api-Version:1.0 -H Content-Type:application/json -b cookies.txt \
-d filter='{"public_cloud_vendor_name":["Google"],"resource_type":["instance"],"purchase_option_type":["on_demand_instance"],"platform":["Linux/UNIX"],"platform_version":[null]}' 


#-d filter='{"public_cloud_vendor_name":["Google"],"cpu_count":[3,4,5],"memory":["5","6","7","8","9"],"resource_type":["instance"],"purchase_option_type":["on_demand_instance"],"platform":["Linux/UNIX"]}' 

#-d filter="{\"purchase_option_type\":[\"on_demand_instance\"],\"platform\":[\"Linux/UNIX\"],\"platform_version\":[null],"cpu_count": [3, 4, 5], "memory": [3, 4, 5]}"



#\"cpu_count\":[2,3,4,5,6,7,8],\"memory\":[2,3,4,5,6,7,8]}"
#-d filter="{\"purchase_option_type\":[\"on_demand_instance\"],\"platform\":[\"Linux/UNIX\"],\"platform_version\":[null],\"cpu_count\":[\"2\",\"3\",\"4\",\"5\",\"6\",\"7\",\"8\"],\"memory\":[\"2\",\"3\",\"4\",\"5\",\"6\",\"7\",\"8\"]}"


#,"datacenter_name":[null]}'

echo ""
