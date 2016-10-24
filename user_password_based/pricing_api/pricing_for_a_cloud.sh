# Assumes authentication script was run and created the cookies.txt file


curl -G https://pricing.rightscale.com/api/prices \
-H X-Api-Version:1.0 \
-H Content-Type:application/json \
-b cookies.txt #\
-d filter='{"cloud_name":["EC2 us-east-1"],"resource_name":["n1-standard-2"],"purchase_option_type":["on_demand_instance"],"platform":["Linux/UNIX"],resource_type:[\"instance\"]}'


#-d filter='{"platform":["Linux/UNIX"]}'




#-d filter='{"cloud_href":["/api/clouds/2175"]}' \
#filter="{resource_name: [${2}]},

#purchase_option_type: ["on_demand_instance"],

#-d filter='{"cloud_href":["/api/clouds/3130"]}'
#-d filter='{"cloud_href":["/api/clouds/2175"]}' \ # google
