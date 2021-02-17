import os
print(os.path.dirname(os.path.abspath(__file__)))
print(os.getcwd())

default_xslt = os.path.join(
    os.path.dirname(os.path.abspath(__file__)),
    'fgdcrse2iso19115-2.xslt')

if not os.path.isFile(default_xslt):
    default_xslt = os.path.join(
        os.getcwd(),
        'fgdcrse2iso19115-2.xslt')
