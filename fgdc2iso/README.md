## Install

To install this webapp install tomcat.

sudo apt-get install tomcat6

Copy this directory (fgdc2iso) to the webapps folder /var/lib/tomcat6/webapps/

Copy the saxon licence file to /var/lib/tomcat6/webapps/fgdc2iso/WEB-INF/lib/

sudo service tomcat6 restart


## WAR Packaging

An alternative way to install the webapp is packaging it into a single WAR file.

Run this in the current directory to build the WAR file

jar cvf fgdc2iso.war .

Then drop the generated WAR file fgdc2iso.war to Tomcat's webapps directory.


## Usage

POST a valid FGDC file to http://localhost:8080/fgdc2iso/ and you should receive
the transformed ISO document. A 409 response code will be raised with errors if
conversion fails. A sample FGDC file, `tl_2009_us_uac00_url.shp.xml`, is included.

    curl http://0.0.0.0:8080/fgdc2iso/ -d @tl_2009_us_uac00_url.shp.xml


## translate.py

Translate data to OSI within a Postgres database over JDBC.

1. Install Java
2. Install Jython
3. Run ./setup.sh
4. Copy blank_run.sh to run.sh
5. Update run.sh
6. ./run.sh
7. Put the kettle on
8. Admire the newly insert data in the xslt_results table
