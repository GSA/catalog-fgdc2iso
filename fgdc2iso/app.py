import sys
import os
import logging
import sys
import datetime
import urlparse
import urllib
import cgi
import uuid
import tempfile
import threading
import java.lang.System as System
import java.lang.Class as Class
import java.io.File as JavaFile
import java.io.StringReader as StringReader
import javax.xml.transform.TransformerConfigurationException as \
    TransformerConfigurationException
import javax.xml.transform.Transformer as Transformer
import javax.xml.transform.TransformerFactory as TransformerFactory
import javax.xml.transform.TransformerException as TransformerException
import javax.xml.transform.stream.StreamResult as StreamResult
import javax.xml.transform.stream.StreamSource as StreamSource
import net.sf.saxon.trans.XPathException as XPathException
import config
import threading

_transform = None

rlock = threading.RLock()


def transform(xmldoc, xslt=config.default_xslt):
    '''
    Runs the transform from the specified xslt against the provided
    document.  The transformer is only loaded on the first run and
    then kept in memory for re-use.
    '''
    global _transform

    if _transform is None:
        tFactory = TransformerFactory.newInstance()
        SAXON_LICENSE_FILE = os.getenv('SAXON_LICENSE_FILE',
                                       default='/home/vcap/tmp/license/saxon-license.lic')
        tFactory.setAttribute('http://saxon.sf.net/feature/licenseFileLocation',
                              SAXON_LICENSE_FILE)
        try:
            _transform = tFactory.newTransformer(StreamSource(JavaFile(xslt)))
        except TransformerConfigurationException, tce:
            print tce
            print '*' * 70
            print 'This is likely that your license file for saxon is '\
                  'missing or that there is a genuine error in the XSLT'

    fid, path, = tempfile.mkstemp(prefix='tmp' + str(uuid.uuid4()))
    os.close(fid)

    rlock.acquire()
    try:
        _transform.transform(StreamSource(StringReader(xmldoc)),
                         StreamResult(JavaFile(path)))
    finally:
        rlock.release()

    f = open(path)
    converted = f.read()
    f.close()
    os.remove(path)
    return converted

def handler(environ, start_response):
    request = environ['wsgi.input'].read().decode('utf-8')
    try:
        result = transform(request)
    except TransformerException, e:
        logging.error("%s" % e)
        start_response("409 Integrity Error", [ ('content-type', 'text/xml') ])
        return ["%s" % e]

    start_response("200 OK", [ ('content-type', 'text/html') ])
    request = environ['wsgi.input'].read().decode('utf-8')
    return [result]

if __name__ == '__main__':
    filename = sys.argv[1]
    print transform(open(filename).read())
    
