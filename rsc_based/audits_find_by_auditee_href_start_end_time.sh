#!/bin/sh

if [ $# -ne 4 ]
then
	echo "USAGE: $0 ACCOUNT_ID START_DATE END_DATE AUDITEE_HREF"
	echo "Where ACCOUNT_ID is the RightScale account ID."
	echo "Where START_DATE is where to start the audit trail in form YYYY-MM-DD"
	echo "Where END_DATE is where to end the audit trail in form YYYY-MM-DD"
	echo "Where AUDITEE_HREF is the HREF for the audit target. E.g. for an instance it'll be something like: /api/clouds/1/instances/DRCA4L58A7FRE"
	exit 1
fi

ACCOUNT_ID=${1}
START_DATE=${2}
END_DATE=${3}
AUDITEE_HREF=${4}


currentDateTs=$(date -j -f "%Y-%m-%d" ${START_DATE} "+%s")
endDateTs=$(date -j -f "%Y-%m-%d" ${END_DATE} "+%s")
offset=86400

# Loop through each day looking for entries for the given auditee_href
while [ "$currentDateTs" -le "$endDateTs" ]
do
  	date=$(date -j -f "%s" $currentDateTs "+%Y/%m/%d")

	# Look through audit entries one hour at a time to avoid timeout or missing entries.
	for hour in 00 01 02 03 04 05 06 07 08 09 10 11 12 13 14 15 16 17 18 19 20 21 22 23
	do
		start_date="${date} ${hour}:00:00 +0000"
		end_date="${date} ${hour}:59:59 +0000"
  		#echo "start date: $start_date; end date: $end_date"
		rsc -a ${ACCOUNT_ID} --xm ":has(:has(:has(.href:val(\"${AUDITEE_HREF}\"))))" cm15 index /api/audit_entries "start_date=${start_date}" "end_date=${end_date}" limit=400
	done

  	currentDateTs=$(($currentDateTs+$offset))
done

