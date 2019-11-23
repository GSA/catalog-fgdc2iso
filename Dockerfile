FROM tomcat:jdk11-openjdk

ARG JYTHON_VERSION=2.7.1
#ARG SAXONPE_VERSION=9-9-1-5J
ARG SAXONPE_VERSION=9-4-0-9J
ARG TOMCAT_WEBAPPS_DIR=/usr/local/tomcat/webapps

# Install dependencies
RUN apt-get update && apt-get install -y \
  default-jdk \
  unzip \
  wget

# Download Jython
RUN cd /tmp \
  && wget -O jython-standalone-$JYTHON_VERSION.jar http://search.maven.org/remotecontent?filepath=org/python/jython-standalone/$JYTHON_VERSION/jython-standalone-$JYTHON_VERSION.jar

RUN cd /tmp \
  && wget http://www.saxonica.com/download/SaxonPE$SAXONPE_VERSION.zip \
  && unzip SaxonPE$SAXONPE_VERSION.zip

# Copy source files
COPY fgdc2iso/fgdc2iso/ $TOMCAT_WEBAPPS_DIR/fgdc2iso/

# Move dependencies into lib
RUN mv -t $TOMCAT_WEBAPPS_DIR/fgdc2iso/WEB-INF/lib/ \
  /tmp/jython-standalone-$JYTHON_VERSION.jar \
  /tmp/saxon9pe.jar

#COPY fgdc2iso.war /usr/local/tomcat/webapps/
#COPY tl_2009_us_uac00_url.shp.xml /tmp
COPY entrypoint.sh /entrypoint.sh

RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
