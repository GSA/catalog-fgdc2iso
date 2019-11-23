[![CircleCI](https://circleci.com/gh/GSA/catalog-fgdc2iso.svg?style=svg)](https://circleci.com/gh/GSA/catalog-fgdc2iso)

# catalog-fgdc2iso

Web service provides transformations from FGDC/RSE to ISO 19115-2.


## Usage

Download the latest `fgdc2iso.war` from the [Releases](./releases) page. Install
the war into Apache Tomcat's directory.

  mv fgdc2iso.war /var/lib/tomcat8/webapps/


## Development

Build the war file to `./build/fgdc2iso.war`.

    $ make build

Run the tests.

    $ make test
