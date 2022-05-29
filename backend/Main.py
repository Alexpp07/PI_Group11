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

class Color_Detection(Resource):
    def image(self):
        global imgA
        global imgB
        global vid
        imgB = imgA
        ret,imgA = vid.read()
        return imgA
        
    def prepareResult(self, frame):
        with open("file.jpg", "wb") as dest:
            jpg = cv2.imencode(".jpg", frame)[1]
            dest.write(jpg)
        image = open("file.jpg", "rb")
        return {"data": str(base64.b64encode(image.read()))}

    def get(self):
        args = request.args
        R = int(args["colorR"])
        G = int(args["colorG"])
        B = int(args["colorB"])
        threshold = int(args["threshold"])
        imgA = self.image()
        frame = ColorDetection(imgA, R, G, B, threshold)
        result = self.prepareResult(frame)
        return result

class Movement_Detection(Resource):
    def image(self):
        global imgA
        global imgB
        global vid
        imgB = imgA
        ret,imgA = vid.read()
        return imgA
        
    def prepareResult(self, frame):
        with open("file.jpg", "wb") as dest:
            jpg = cv2.imencode(".jpg", frame)[1]
            dest.write(jpg)
        image = open("file.jpg", "rb")
        return {"data": str(base64.b64encode(image.read()))}

    def get(self):
        imgA = self.image()
        global imgB
        frame = MovementDetection(imgA,imgB)
        result = self.prepareResult(frame)
        return result

class Eye_Tracking(Resource):
    def image(self):
        global imgA
        global imgB
        global vid
        global ret

        imgB = imgA
        ret,imgA = vid.read()
        return imgA
        
    def prepareResult(self, frame):
        with open("file.jpg", "wb") as dest:
            jpg = cv2.imencode(".jpg", frame)[1]
            dest.write(jpg)
        image = open("file.jpg", "rb")
        return {"data": str(base64.b64encode(image.read()))}
    
    def get(self):
        img = self.image()
        frame = EyeTracking(img)
        result = self.prepareResult(frame)
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
