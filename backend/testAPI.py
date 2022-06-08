import requests

BASE = "http://127.0.0.1:5000/"

#response = requests.get(BASE + "color_detection", {"colorR":100,"colorG":100,"colorB":100,"threshold":25, "rectangles":16})
#print(response.json())

response = requests.get(BASE + "movement_detection", {"rectangles":16})
print(response.json())

#response = requests.get(BASE + "eye_tracking", {"rectangles":16})
#print(response.json())
