import base64

import requests

BASE = "http://127.0.0.1:5000/"

#response = requests.get(BASE + "color_detection", {"colorR":100,"colorG":100,"colorB":100,"threshold":25, "rectangles":16})
#print(response.json())

response = requests.get(BASE + "movement_detection", {"rectangles":8})
print(response.json())

#response = requests.get(BASE + "eye_tracking", {"rectangles":16})
#print(response.json())

#f = open("teddybear.mid","rb")
#temp = base64.b64encode(f.read())
#response = requests.post(BASE + "file", {"file":str(temp),"name":"teddybear"})
#print(response.json())

#response = requests.post(BASE + "square", {"rectangle":8,"sound":"teddybear"})
#print(response.json())