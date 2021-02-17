import os
print(os.path.dirname(os.path.abspath(__file__)))
print(os.getcwd())

default_xslt = os.path.join(
    os.path.dirname(os.path.abspath(__file__)),
    # os.getcwd(),
    'fgdcrse2iso19115-2.xslt')
