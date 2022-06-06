import cv2
from os.path import exists
from MovementDetection import MovementDetection
from ColorDetection import ColorDetection
from eye_tracking import EyeTracking
import numpy as np
import io
import base64


from flask import Flask, request
from flask_restful import Api, Resource

app = Flask(__name__)
api = Api(app)


#vid = None
#ret = None
#imgB = None
#imgA = None
#global vid
#global ret
#global imgA
#global imgB
def image():
    global imgA
    global imgB
    global vid
    imgB = imgA
    ret,imgA = vid.read()
    return imgA
    
def prepareResult(frame, grid_size, coords):
    row = 0
    column = 0
    if grid_size == 4:
        row = 2
        column = 2
    elif grid_size == 8:
        row = 2
        column = 4
    elif grid_size == 12:
        row = 3
        column = 4
    elif grid_size == 16:
        row = 4
        column = 4
    h, w, _ = frame.shape
    dy, dx = h/row, w/column
    
    for x in np.linspace(start=dx, stop=w-dx, num=column-1):
        x = int(round(x))
        cv2.line(frame, (x, 0), (x,h), color=(0,0,0), thickness=1)
        
    for y in np.linspace(start=dy, stop=h-dy, num=row-1):
        y = int(round(y))
        cv2.line(frame, (0, y),(w,y), color=(0,0,0), thickness=1)
    if coords[0] != None and coords[1] != None:
        temp_copy = frame.copy()
        squareX = 0
        squareY = 0
        stopped = False
        #figure out which square should be highlighted
        while not stopped:
            if not squareX < coords[0] < squareX + dx:
                squareX += dx
                stopped = False
            else:
                stopped = True
            if not squareY < coords[1] < squareY + dy:
                squareY += dy
                stopped = False  
        
        temp_copy = cv2.rectangle(temp_copy, (int(squareX), int(squareY)), (int(squareX + dx), int(squareY + dy)), (100, 100,100), -1)
        
        cv2.addWeighted(frame, 0.5, temp_copy, 0.5, 0, frame)
        
        x = int(coords[0])
        y = int(coords[1])
        frame = cv2.circle(frame, (x, y), radius=5, color=(255, 0, 0), thickness=-1)
    
    with open("file.jpg", "wb") as dest:
        jpg = cv2.imencode(".jpg", frame)[1]
        dest.write(jpg)
    image = open("file.jpg", "rb")
    return {"data": str(base64.b64encode(image.read()))}
        
class Color_Detection(Resource):

    def get(self):
        args = request.args
        R = int(args["colorR"])
        G = int(args["colorG"])
        B = int(args["colorB"])
        threshold = int(args["threshold"])
        rect = int(args["rectangles"])
        imgA = image()
        frame, coords = ColorDetection(imgA, R, G, B, threshold)
        result = prepareResult(frame, rect, coords)
        return result

class Movement_Detection(Resource):
    def get(self):
        args = request.args
        rect = int(args["rectangles"])
        imgA = image()
        global imgB
        frame, coords = MovementDetection(imgA,imgB)
        result = prepareResult(frame, rect, coords)
        return result

class Eye_Tracking(Resource):
    def get(self):
        args = request.args
        rect = int(args["rectangles"])
        img = image()
        frame, coords = EyeTracking(img)
        result = prepareResult(frame, rect, coords)
        return result
        

api.add_resource(Color_Detection,"/color_detection")
api.add_resource(Movement_Detection,"/movement_detection")
api.add_resource(Eye_Tracking,"/eye_tracking")


if __name__ == "__main__":
    vid = cv2.VideoCapture(0)
    ret,  imgA = vid.read()
    ret,  imgB = vid.read()

    app.run(debug=True)

    vid.release()
