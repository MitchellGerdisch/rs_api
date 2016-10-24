echo ""
curl -sG https://pricing.rightscale.com/api/prices -H X-Api-Version:1.0 -H Content-Type:application/json -b cookies.txt \
-d filter='{"cloud_href":["/api/clouds/2175"],"purchase_option_type":["on_demand_instance"],"platform":["Linux/UNIX"],"datacenter_name":["us-central1-c"],"platform_version":[null]}'
#"resource_name":["n1-standard-2"],


echo ""
