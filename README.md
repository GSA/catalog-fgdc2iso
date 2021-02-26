[![CircleCI](https://circleci.com/gh/GSA/catalog-fgdc2iso.svg?style=svg)](https://circleci.com/gh/GSA/catalog-fgdc2iso)

# catalog-fgdc2iso

Web service provides XML transformations from FGDC/RSE to ISO 19115-2 using the XSLT
`./fgdc2iso/fgdcrse2iso19115-2.xslt`. 

## Usage

When updates to the master branch are pushed to the repository, a github [action](https://github.com/GSA/datagov-deploy/actions) will be run to
build a new version of the WAR file, test it, and if successful, tag and release it.

Alternatively, the WAF file can be installed by downloading the latest `fgdc2iso.war`
from the [Releases](https://github.com/GSA/catalog-fgdc2iso/releases/latest) page or from 'make build' and putting the
WAR file into Apache Tomcat's webapps directory. The test XML file is included in the WAR file.

    mv fgdc2iso.war /opt/tomcat/webapps/

POST your XML to the web service.

    $ curl http://localhost:8080/fgdc2iso -d @test/fixtures/tl_2009_us_uac00_url.shp.xml

If successful, the response will contain the transformed document. If
unsuccessful, HTTP status 409 will be returned with an error message response.

## Development

Make help

    $ make help

Build the WAR file to `./build/fgdc2iso.war`.

    $ make build

Run the tests. You must have a license in order to run the tests. Copy the saxon
license to a file named `saxon-license.lic` in the root directory and it will be
mounted in volume attached to the the docker container. The saxon license can be
found in the [datagov-delopy](https://github.com/GSA/datagov-deploy/) Ansible vault.
To remove the volume and containers after testing run `make clean`

    $ make test

Run clean, build, test, and then bring the service down
To remove the volume and containers after testing run `make clean`

    $ make all

## Deploying to cloud.gov

Copy the vars.yml.template and rename it to vars.yml.

**For development**:

Create a user-provided service secrets for the saxon-license:

Confirm if the space has the necessary secrets by running:
> `cf service ${app_name}-secrets`

If the above service does not exist, you will need to get the saxon-license stored in the ansible-vault or from the catalog-fgdc2iso server. Copy it to the root of the repo and rename it `saxon-licence.lic.txt`.

Encode the saxon-license and write it to a new file;
`base64 saxon-license.lic > saxon-encoded.txt`

Then create the user-provided service substituting ${app-name} for your application's name in vars.yml:
> `cf cups ${app_name}-secrets -p <(jq -c --null-input --rawfile secret saxon-encoded.txt '{SAXON_LICENSE: $secret}')`

Create the app by running:
> `cf push --vars-file vars.yml fgdc2iso -p build/fgdc2iso.war`
