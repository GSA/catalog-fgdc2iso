[![CircleCI](https://circleci.com/gh/GSA/catalog-fgdc2iso.svg?style=svg)](https://circleci.com/gh/GSA/catalog-fgdc2iso)

# catalog-fgdc2iso

Web service provides transformations from FGDC/RSE to ISO 19115-2.


## Usage

Download the latest `fgdc2iso.war` from the [Releases](./releases) page. Install
the war into Apache Tomcat's directory.

    mv fgdc2iso.war /opt/tomcat/webapps/

POST your XML to the web service.

    $ curl http://localhost:8080/fgdc2iso -d @test/fixtures/tl_2009_us_uac00_url.shp.xml

If successful, the response will contain the transformed document. If
unsuccessful, HTTP status 409 will be returned with an error message response.


## Development

Make help

    $ make help

Build the war file to `./build/fgdc2iso.war`.

    $ make build

Run the tests. You must have a license in order to run the tests. Copy your
license to `saxon-license.lic` and it will be mounted into the docker container.

    $ make test

Run clean, build, test, and then bring the service down

    $ make all

## Pushing updates to the master branch will run make all and if sucessful it will relase a new version of the WAR file.
