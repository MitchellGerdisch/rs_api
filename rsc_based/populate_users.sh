# get the file containing the student information
while [  -z ${filepath} ]
do
	echo ""
	echo "Please enter the path to the file containing the student information for the students to add to the account."
	echo "Each line must represent one student and be a comma-separated list of the form:"
	echo "FirstName,LastName,CompanyName,EmailAddress,PhoneNumber,Password"
	echo ""
	
	read filepath
done

if [ ! -f ${filepath} ]
then
	echo "File not found."
	exit 1
fi

# Check to see that the rsc tool is installed.
rsc --version > /dev/null
if [ $? -ne 0 ]
then
	echo "Go to https://github.com/rightscale/rsc/blob/master/README.md and install the rsc tool for your OS."
	exit 1
fi

# Force the user to go through rsc setup to make sure it is configured for the subsequent steps.
echo "Please respond to the rsc setup prompts for the account you'll be populating."
echo "NOTE: The username/password being asked for here is your RightScale username and password."
rsc setup

echo ""

cat ${filepath} |
sed 's/,/ /g' |
while read firstName lastName companyName emailAddress phoneNumber password
do
	echo "Processing ${emailAddress}"

	# Create the user if not already exists and extract the user href
	user_href=`rsc --pp --dump=debug cm15 create /api/users "user[first_name]=${firstName}" "user[last_name]=${lastName}" "user[company]=${companyName}" "user[email]=${emailAddress}" "user[phone]=${phoneNumber}" "user[password]=${password}" 2>&1 >/dev/null |
		grep Location | 
		sed 's/  *//g' | 
		cut -d":" -f2`

	# Give the user the observer and actor roles to allow the user to launch and manage the CAT
	for role in observer actor 
	do
		# redirect to /dev/null so that duplicate attempt messages are not echoed to the user
		rsc --pp cm15 create /api/permissions "permission[role_title]=${role}" "permission[user_href]=${user_href}" &> /dev/null
	done
done
