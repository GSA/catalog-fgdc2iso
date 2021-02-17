import os

default_xslt = os.path.join(
    os.path.dirname(os.path.abspath(__file__)),
    'fgdcrse2iso19115-2.xslt')
try:
    if not os.path.isFile(default_xslt):
        default_xslt = os.path.join(
            os.getcwd(),
            'fgdcrse2iso19115-2.xslt')
except Exception as e:
    print('There is a problem with this code: ')
