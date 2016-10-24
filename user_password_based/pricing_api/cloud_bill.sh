echo ""

curl -Gs https://analytics.rightscale.com/api/cloud_bill_metrics/actions/grouped_time_series \
      -b cookies.txt \
      -H X-Api-Version:1.0 \
      -d start_time=2016-04-01 \
      -d end_time=2016-05-01 \
      -d group='[["cloud_vendor_name","cloud_vendor_account_id"]]'
#      -d group='[["product"]]'
#-d cloud_bill_filters='[{"type":"cloud_bill:product_category","value":"Storage"}]' \






#curl -sG -H X-Api-Version:1.0 -H Content-Type:application/json -b cookies.txt https://analytics.rightscale.com%2Fapi%2Fcloud_bill_metrics%2Factions%2Fgrouped_time_series%3Fstart_time%3D2016-04-01T00%3A00%3A00%26end_time%3D2016-05-01T00%3A00%3A00%26group%3D%5B%22product%22%2C%22product%22%5D%26group%3D%5B%22cloud_vendor_account_name%22%5D

#curl -sG -H X-Api-Version:1.0 -H Content-Type:application/json -b cookies.txt https://analytics.rightscale.com/api/cloud_bill_metrics/actions/grouped_time_series?start_time=2015-01-01T00%3A00%3A00&end_time=2015-02-01T00%3A00%3A00&group=%5B%22product%22%2C+%22product%22%5D&group=%5B%22cloud_vendor_account_name%22%5D


#curl -sG -H X-Api-Version:1.0 -H Content-Type:application/json -b cookies.txt https://analytics.rightscale.com/api/cloud_bill_metrics/actions/grouped_time_series?end_time=2016-05-01T00:00:00&start_time=2016-04-01T00:00:00
#&group=%5Bcloud_vendor_account_name%5D



#-d filter='{"cloud_href":["/api/clouds/2179"],"purchase_option_type":["on_demand_instance"],"platform":["Linux/UNIX"],"platform_version":[null],"datacenter_name":[null]}'
#"resource_name":["medium"],"purchase_option_type":["on_demand_instance"],"platform":["Linux/UNIX"],"platform_version":[null],"datacenter_name":[null]}'
echo ""
