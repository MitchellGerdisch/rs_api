echo ""
curl -sG https://pricing.rightscale.com/api/prices -H X-Api-Version:1.0 -H Content-Type:application/json -b cookies.txt -d filter='{"cloud_href":["/api/clouds/2179"],"purchase_option_type":["on_demand_instance"],"platform":["Linux/UNIX"],"platform_version":[null],"datacenter_name":[null]}'
#"resource_name":["medium"],"purchase_option_type":["on_demand_instance"],"platform":["Linux/UNIX"],"platform_version":[null],"datacenter_name":[null]}'
echo ""
