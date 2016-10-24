#curl https://pricing.rightscale.com/api/clouds \
      #-H X-Api-Version:1.0 \
      #-b cookies.txt


curl -G https://pricing.rightscale.com/api/prices \
-H X-Api-Version:1.0 \
-H Content-Type:application/json \
-b cookies.txt \
-d filter='{"cloud_href":["/api/clouds/3403"]}
#-d filter='{"cloud_href":["/api/clouds/3389"]}



#,"resource_type":["instance"],"purchase_option_type":["spot_instance"],"platform":["Linux/UNIX"]}'
#,"platform_version":[null]}'
#"cpu_count":["1","2","3","4"],

#-d filter='{"cloud_href":["/api/clouds/2175"],"cpu_count":["1","2","3","4"],"resource_type":["instance"],"purchase_option_type":["on_demand_instance"],"platform":["Linux/UNIX"],"platform_version":[null]}'

#-d filter='{"cloud_href":["/api/clouds/3152","/api/clouds/1"]}'


