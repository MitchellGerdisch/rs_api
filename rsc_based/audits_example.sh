
#rsc --pp --xm ':has(.summary) > .summary' cm15 index /api/audit_entries "start_date=2016/01/01 00:00:00 +0000" "end_date=2016/01/14 00:00:00 +0000" limit=200 "filter[]=user_email==mitchell.gerdisch@rightscale.com"

#rsc --pp cm15 index /api/audit_entries "start_date=2015/12/13 00:00:00 +0000" "end_date=2016/01/08 00:00:00 +0000" limit=1000 "filter[]=auditee_href==/api/clouds/1/instances/209955711003"
#/api/clouds/1/instances/DRCA4L58A7FRE"

#--x1 ':has(.rel:val("self")).href' 

#rsc --dump=debug --pp cm15 index /api/audit_entries "start_date=2015/12/13 00:00:00 +0000" "end_date=2016/01/08 00:00:00 +0000" limit=1000 "filter[]=auditee_href==/api/clouds/1/instances/DRCA4L58A7FRE"

#rsc --dump=debug --pp cm15 index /api/audit_entries "start_date=2015/12/13 00:00:00 +0000" "end_date=2016/01/15 00:00:00 +0000" limit=1000 "filter[]=auditee_href==/api/clouds/1/instances/7FUV3SK0COUQL"

#rsc --dump=debug --pp cm15 index /api/audit_entries "start_date=2015/12/13 00:00:00 +0000" "end_date=2016/01/15 00:00:00 +0000" limit=1000 

#rsc --dump=debug --pp cm15 index /api/audit_entries "start_date=2015/12/14 16:00:00 +0000" "end_date=2015/12/16 00:00:00 +0000" limit=200

rsc --pp -a 82095 --xm ":has(:has(:has(.href:val(\"/api/clouds/1/instances/DRCA4L58A7FRE\"))))" cm15 index /api/audit_entries "start_date=2015/12/14 16:00:00 +0000" "end_date=2015/12/16 00:00:00 +0000" limit=200
