#!/bin/sh

if [ $# -ne 4 ]
then
	echo "USAGE: $0 ACCOUNT_ID START_DATE START_TIME AUDITEE_HREF"
	echo "Where ACCOUNT_ID is the RightScale account ID."
	echo "Where START_DATE is the date for the the audit trail in form YYYY-MM-DD UNIVERSAL TIME."
	echo "Where START_TIME is the time in the CloudTrails in form HH:MM:SS UNIVERSAL TIME."
	echo "Where AUDITEE_HREF is the HREF for the audit target. E.g. for an instance it'll be something like: /api/clouds/1/instances/DRCA4L58A7FRE"
	exit 1
fi

ACCOUNT_ID=${1}
START_TIMESTAMP="${2} ${3}"
AUDITEE_HREF=${4}

unixtimestamp=`date -j -f "%Y-%m-%d %T" "${START_TIMESTAMP}" "+%s"`
echo "ts: ${unixtimestamp}"
unix_starttime=$((unixtimestamp-300))  # 300 seconds earlier
unix_endtime=$((unixtimestamp+300))  # 300 seconds later

start_time=`date -j -f "%s" ${unix_starttime} "+%Y/%m/%d %T"`
end_time=`date -j -f "%s" ${unix_endtime} "+%Y/%m/%d %T"`
echo "start date: $start_time; end date: $end_time"
rsc -a ${ACCOUNT_ID} --xm ":has(:has(:has(.href:val(\"${AUDITEE_HREF}\"))))" cm15 index /api/audit_entries "start_date=${start_time} +0000" "end_date=${end_time} +0000" limit=400

