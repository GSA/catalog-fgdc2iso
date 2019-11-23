FROM tomcat:jdk11-openjdk

ARG JYTHON_VERSION=2.7.1
#ARG SAXONPE_VERSION=9-9-1-5J
ARG SAXONPE_VERSION=9-4-0-9J

ENV TOMCAT_WEBAPPS_DIR=/usr/local/tomcat/webapps

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
COPY fgdc2iso/ /app/

# Move dependencies into lib
RUN mv -t /app/WEB-INF/lib/ \
  /tmp/jython-standalone-$JYTHON_VERSION.jar \
  /tmp/saxon9pe.jar

# Build the .war file
RUN jar --create --verbose --file $TOMCAT_WEBAPPS_DIR/fgdc2iso.war -C /app .
