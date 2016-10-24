echo "Need to edit this file with the variables before running."
echo "If you've done that, hit return otherwise ctld-x out"
read response

cloudNumber=1
cpShareVolumeHref="/api/clouds/1/volumes/7ID83HJCQPDBO"
irInstanceHref="/api/clouds/1/instances/3KSMUSTICESD1"
cpShareVolumeDeviceName="/dev/sdf"

rsc cm15 create /api/clouds/$cloudNumber/volume_attachments "volume_attachment[volume_href]=$cpShareVolumeHref" "volume_attachment[instance_href]=$irInstanceHref" "volume_attachment[device]=$cpShareVolumeDeviceName" "volume_attachment[settings][delete_on_termination]=true"

