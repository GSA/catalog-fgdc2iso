
# TODO: these uncommented lines should work; env variable does not exist at app runtime
# mktmp for writing saxon-license
# export SAXON_LICENSE_FILE=$(mktemp -d)/saxon-license.lic

set -o errexit
set -o pipefail

mkdir /home/vcap/tmp/license

# This export does not currently work (the environment variable does not persist to application parsing), 
#   set default manually in app.py to be /home/vcap/tmp/license/saxon-license.lic
export SAXON_LICENSE_FILE=/home/vcap/tmp/license/saxon-license.lic

# get saxon license from cups secret
encoded_license=$(echo $VCAP_SERVICES | jq -r '.[] | .[] | .credentials | .SAXON_LICENSE')

# decode the env variable into a file at SAXON_LICENSE_FILE
echo $encoded_license | base64 -di > $SAXON_LICENSE_FILE
