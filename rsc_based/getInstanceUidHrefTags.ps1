param($a, $c)

$ACCOUNT_NUM = $a
$CLOUD_NUM = $c

# Get the instance hrefs in the given account for the given cloud (Azure US East in this case)
$INSTANCE_HREFS = .\rsc -a $ACCOUNT_NUM --xm ':has(.rel:val(\"self\")).href' cm15 index /api/clouds/$CLOUD_NUM/instances
# Write-Output $INSTANCE_HREFS


# Loop through the Instance HREFs and process each instance
Foreach ($INSTANCE_HREF in $INSTANCE_HREFS)
{
	# Remove any quotes around the instance HREF
	$INSTANCE_HREF = $INSTANCE_HREF.replace("`"","")

    # ONLY report UNMANAGED instances which will be instances without a ServerTemplate.
    $SERVER_TEMPLATE_HREF = ((.\rsc cm15 show $INSTANCE_HREF | ConvertFrom-Json).links | Where rel -eq server_template).href
    if ($SERVER_TEMPLATE_HREF -eq $null) {
	
		# Get the Instance UID and then remove any double quotes that may have come along from the api call
		$INSTANCE_UID = .\rsc -a $ACCOUNT_NUM --x1 '.resource_uid' cm15 show $INSTANCE_HREF
		$INSTANCE_UID = $INSTANCE_UID.replace("`"","")
		
		# Get the Instance tags and then remove any double quotes that may have come along
		$INSTANCE_TAGS = .\rsc -a $ACCOUNT_NUM --xm '.tags.name' cm15 by_resource /api/tags/by_resource "resource_hrefs[]=$INSTANCE_HREF"
		$INSTANCE_TAGS = $INSTANCE_TAGS -replace("`"","")
	
		# remove newlines from the list of tags
		$OUTPUT_TAGS = $INSTANCE_TAGS -replace("`n")
		# convert the list of tags to a carat=separated list of tags
		$OUTPUT_TAGS = $OUTPUT_TAGS -join("^")
		
		# build the output string or the given instance as a semicolon separated list of items
		$OUTPUT_STRING = $INSTANCE_UID.split("`n")[0] + ";" + $INSTANCE_HREF.split("`n")[0] + ";" + $OUTPUT_TAGS
		
		# remove quotes around the strings that came from api calls
		$OUTPUT_STRING = $OUTPUT_STRING.replace("`"","")
	
		# print out the instnace's line of data
		Write-Output $OUTPUT_STRING
	}
}
 
  
