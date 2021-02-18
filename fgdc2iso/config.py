import os

# this should work for local build
default_xslt = os.path.join(
    os.path.dirname(os.path.abspath(__file__)),
    'fgdcrse2iso19115-2.xslt')

# this should be the path for cloud.gov
if not os.path.isfile(default_xslt):
    default_xslt = os.path.join(
        os.getcwd(),
        'fgdcrse2iso19115-2.xslt')