import base64

import requests
import time
BASE = "http://127.0.0.1:8080/"


while True:
    start = time.time()
    response = requests.get(BASE + "color_detection", {"colorR":100,"colorG":100,"colorB":100,"threshold":25, "rectangles":16})
    stop = time.time()
    #print(response.json())
    print("Color:" + str(stop-start))

    time.sleep(0.5)

    start2 = time.time()
    response = requests.get(BASE + "movement_detection", {"rectangles":16})
    stop2 = time.time()
    #print(response.json())
    print("Movement:" + str(stop2-start2))

    time.sleep(0.5)
    start3 = time.time()
    response = requests.get(BASE + "eye_tracking", {"rectangles":8})
    stop3 = time.time()
    #print(response.json())
    print("Eye:" + str(stop3-start3))
    time.sleep(1)



#f = open("teddybear.mid","rb")
#temp = base64.b64encode(f.read())
#response = requests.post(BASE + "file", {"file":str(temp),"name":"teddybear"})
#print(response.json())

#response = requests.post(BASE + "square", {"rectangle":8,"sound":"teddybear"})
#print(response.json())