
#rsc --pp --xm ':has(.summary) > .summary' cm15 index /api/audit_entries "start_date=2016/01/01 00:00:00 +0000" "end_date=2016/01/14 00:00:00 +0000" limit=200 "filter[]=user_email==mitchell.gerdisch@rightscale.com"

rsc --pp cm15 index /api/audit_entries "start_date=2015/11/18 11:30:00 +0000" "end_date=2015/11/18 18:40:00 +0000" limit=1000

#--x1 ':has(.rel:val("self")).href' 


