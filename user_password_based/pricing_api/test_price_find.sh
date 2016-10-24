echo ""
curl -sG https://pricing.rightscale.com/api/prices \
-H X-Api-Version:1.0 \
-H Content-Type:application/json \
-H "Authorization: Bearer ${1}" \
-d filter='{"cloud_href":["/api/clouds/1"]}'

