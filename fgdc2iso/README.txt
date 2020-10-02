-------------
Install
-------------

Install the war into Apache Tomcat's directory.

    mv fgdc2iso.war /opt/tomcat/webapps/

POST your XML to the web service.

    $ curl http://localhost:8080/fgdc2iso -d @test/fixtures/tl_2009_us_uac00_url.shp.xml

If successful, the response will contain the transformed document. If
unsuccessful, HTTP status 409 will be returned with an error message response.

USAGE
------

POST FGDC file to http://0.0.0.0:8080/fgdc2iso/ and you should recieve ISO document back if valid.
A 409 will be raised with errors if conversion failes.


-------
Example
-------

tl_2009_us_uac00_url.shp.xml FGDC file is included as sample.


Run 

curl http://0.0.0.0:8080/fgdc2iso/ -d @tl_2009_us_uac00_url.shp.xml

and the ISO document should be returned.



