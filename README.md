[![CircleCI](https://circleci.com/gh/GSA/catalog-fgdc2iso.svg?style=svg)](https://circleci.com/gh/GSA/catalog-fgdc2iso)

# catalog-fgdc2iso

Web service provides transformations from FGDC/RSE to ISO 19115-2.


## Usage

Download the latest `fgdc2iso.war` from the [Releases](./releases) page. Install
the war into Apache Tomcat's directory.

    mv fgdc2iso.war /var/lib/tomcat8/webapps/

Install the [SaxonPE](http://www.saxonica.com/download/java.xml) license file to
`/etc/saxon-license.lic`.

POST your XML to the web service.

    $ curl http://localhost:8080/fgdc2iso -d @test/fixtures/tl_2009_us_uac00_url.shp.xml

If successful, the response will contain the transformed document. If
unsuccessful, HTTP status 409 will be returned with an error message response.


## Development

Build the war file to `./build/fgdc2iso.war`.

    $ make build

Run the tests. You must have a license in order to run the tests. Copy your
license to `saxon-license.lic` and it will be mounted into the docker container.

    $ make test


### Continuous Integration

Because testing requires the license, you must add your license file as
a secret. The easiest way to do this is to add a single environment variable,
`SAXONPE_LICENSE` with your newline-encoded your license. During the CI build,
you can write out the license with `printf`.

Newline-encode your license (for LF systems) with GNU sed.

   $ sed -z -e 's/\n/\\n/g' saxon-license.lic

...or with BSD.

   $ paste -s -d'!' saxon-license.lic | sed -e 's/!/\\n/g'
