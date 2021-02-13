
# TODO: these uncommented lines should work
# mktmp for writing saxon-license
# SAXON_LICENSE_FILE=$(mktemp -d)/saxon-license.lic

# point app at tmp file
# export LICENSE_FILE_LOCATION=$SAXON_LICENSE_FILE

set -o errexit
set -o pipefail

mkdir /home/vcap/tmp/license
SAXON_LICENSE_FILE=/home/vcap/tmp/license/saxon-license.lic

# get saxon license from cups secret
encoded_license=$(echo $VCAP_SERVICES | jq -r '.[] | .[] | .credentials | .SAXON_LICENSE')

# decode the env variable
echo $encoded_license | base64 -di > $SAXON_LICENSE_FILE
