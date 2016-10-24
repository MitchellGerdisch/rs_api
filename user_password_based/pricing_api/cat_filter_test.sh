echo ""
date
echo ""
curl -sG https://pricing.rightscale.com/api/prices -H X-Api-Version:1.0 -H Content-Type:application/json -b cookies.txt \
-d filter='{"cloud_href":["/api/clouds/3394"]}' 
#"cpu_count":["1","2"],"resource_type":["instance"],"purchase_option_type":["on_demand_instance"],"platform":["Linux/UNIX"],"platform_version":[null]}'

#-d filter='{"cloud_href":["/api/clouds/1","/api/clouds/2","/api/clouds/3","/api/clouds/4","/api/clouds/5","/api/clouds/6","/api/clouds/7","/api/clouds/8","/api/clouds/9","/api/clouds/2178","/api/clouds/2179","/api/clouds/2181","/api/clouds/2183","/api/clouds/2182","/api/clouds/2175"],"cpu_count":["4","5","6","7","8"],"resource_type":["instance"],"purchase_option_type":["on_demand_instance"],"platform":["Linux/UNIX"]}'


#{"public_cloud_vendor_name":["Google"],"cpu_count":[2,4],"memory":["3.6","3.75","4"],"resource_type":["instance"],"purchase_option_type":["on_demand_instance"],"platform":["Linux/UNIX"],"platform_version":[null]}' 


#-d filter='{"public_cloud_vendor_name":["Google"],"cpu_count":[3,4,5],"memory":["5","6","7","8","9"],"resource_type":["instance"],"purchase_option_type":["on_demand_instance"],"platform":["Linux/UNIX"]}' 

#-d filter="{\"purchase_option_type\":[\"on_demand_instance\"],\"platform\":[\"Linux/UNIX\"],\"platform_version\":[null],"cpu_count": [3, 4, 5], "memory": [3, 4, 5]}"



#\"cpu_count\":[2,3,4,5,6,7,8],\"memory\":[2,3,4,5,6,7,8]}"
#-d filter="{\"purchase_option_type\":[\"on_demand_instance\"],\"platform\":[\"Linux/UNIX\"],\"platform_version\":[null],\"cpu_count\":[\"2\",\"3\",\"4\",\"5\",\"6\",\"7\",\"8\"],\"memory\":[\"2\",\"3\",\"4\",\"5\",\"6\",\"7\",\"8\"]}"


#,"datacenter_name":[null]}'

echo ""
