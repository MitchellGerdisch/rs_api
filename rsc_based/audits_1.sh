#!/bin/sh

if [ $# -ne 4 ]
then
	echo "USAGE: $0 ACCOUNT_ID START_DATE END_DATE AUDITEE_HREF"
	echo "Where ACCOUNT_ID is the RightScale account ID."
	echo "Where START_DATE is where to start the audit trail in form YYYY/MM/DD"
	echo "Where END_DATE is where to end the audit trail in form YYYY/MM/DD"
	echo "Where AUDITEE_HREF is the HREF for the audit target. E.g. for an instance it'll be something like: /api/clouds/1/instances/DRCA4L58A7FRE"
	exit 1
fi

ACCOUNT_ID=${1}
start_date="${2} 16:00:00 +0000"
end_date="${3} 20:00:00 +0000"
AUDITEE_HREF=${4}

	rsc -a ${ACCOUNT_ID} --xm ":has(:has(:has(.href:val(\"${AUDITEE_HREF}\"))))" cm15 index /api/audit_entries "start_date=${start_date}" "end_date=${end_date}" limit=200

exit
currentDateTs=$(date -j -f "%Y-%m-%d" ${START_DATE} "+%s")
endDateTs=$(date -j -f "%Y-%m-%d" ${END_DATE} "+%s")
offset=86400

while [ "$currentDateTs" -le "$endDateTs" ]
do
  	date=$(date -j -f "%s" $currentDateTs "+%Y/%m/%d")
	start_date="${date} 00:00:00 +0000"
	end_date="${date} 23:59:59 +0000"
  	echo $start_date $end_date

  	currentDateTs=$(($currentDateTs+$offset))
done


#for i in `seq 0 23`
#do
#done
