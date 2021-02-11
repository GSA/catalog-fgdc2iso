# mktmp for writing saxon-license
# SAXON_LICENSE_FILE=$(mktemp -d)/saxon-license.lic

# get saxon license from cups secret
license=$(echo $VCAP_SERVICES | jq '.[] | .[] | .credentials | .SAXON_LICENSE')

# write saxon license to tmp file
echo $license > /etc/saxon-license.lic

export WELCOME_MESSAGE="Welcome to PCF"
echo $WELCOME_MESSAGE
echo $WELCOME_MESSAGE
echo $WELCOME_MESSAGE
echo $WELCOME_MESSAGE
echo $WELCOME_MESSAGE
echo $WELCOME_MESSAGE
echo $WELCOME_MESSAGE
echo $WELCOME_MESSAGE
echo $WELCOME_MESSAGE
echo $WELCOME_MESSAGE
echo $WELCOME_MESSAGE

# point app at tmp file
# export LICENSE_FILE_LOCATION=$SAXON_LICENSE_FILE