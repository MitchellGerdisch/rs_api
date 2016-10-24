
echo ""
curl -sG https://pricing.rightscale.com/api/prices -H X-Api-Version:1.0 -H Content-Type:application/json -b cookies.txt \
-d filter='{"purchase_option_type":["reserved_instance"]}'
#-d filter='{"cloud_href":["/api/clouds/6"],"account_href":["/api/accounts/30601"],"purchase_option_type":["reserved_instance"]}'
#,"platform":["Linux/UNIX"],"platform_version":[null]}'
#"purchase_option_type":["on_demand_instance","reserved_instance","spot_instance"],"platform":["Linux/UNIX"],"platform_version":[null]}'

#,"datacenter_name":[null]}'

echo ""
