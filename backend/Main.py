import cv2
from os.path import exists
from MovementDetection import MovementDetection
from ColorDetection import ColorDetection
from eye_tracking import EyeTracking

import numpy as np
import io
import base64
import threading
import pygame

from flask import Flask, request, Response
from flask_restful import Api, Resource
from flask_cors import CORS

app = Flask(__name__)
api = CORS(app)
api = Api(app)

def image():
    global imgA
    global imgB
    global vid
    imgB = imgA
    ret,imgA = vid.read()
    return imgA
    
def play_sound(name):
    clock = pygame.time.Clock()
    pygame.mixer.music.load("./MIDI_files/" + name + ".midi")
    pygame.mixer.music.play()
    while pygame.mixer.music.get_busy():
        clock.tick(30) # check if playback has finished
    
def prepareResult(frame, grid_size, coords):
    
    global square_threads
    square_threads = {x:y for (x, y) in square_threads.items() if y.is_alive()}
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
        
        Xs = ceil(squareX/dx) + 1
        Ys = ceil(squareY/dy) + 1
        
        square = Ys * 4 + Xs
        global squares
        filename = squares[str(square)]
        
        if filename != None and square_threads[str(square)] == None:
            
            square_threads[str(square)] = threading.Thread(target=play_sound, args=(filename)).start()
        
    with open("file.jpg", "wb") as dest:
        jpg = cv2.imencode(".jpg", frame)[1]
        dest.write(jpg)
    image = open("file.jpg", "rb")
    return {"data": str(base64.b64encode(image.read()))}
        
def reload_squares():
    global squares
    f = open("save.txt","r")
    for i in range(16):
        midi = f.readline().strip()
        if midi != "":
            squares[str(i+1)] = f.readline().strip()
    
def save_squares():
    global squares
    f = open("save.txt","w")
    for i in range(16):
        if squares[str(i+1)] != None:
            f.write(squares[str(i+1)] + "\n")
        else:
            f.write("\n")
            
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
        
class Receive_File(Resource):
    def post(self):
        args = request.args
        midifile = args["file"]
        name = args["name"]
        midifile = bin(base64.b64decode(midifile))
        writeout = open("./" + name + ".midi", "wb")
        writeout.write(midifile)
        return '{}', 200
        
class List_Files(Resource):
    def get(self):
        list_of_files = os.listdir('./MIDI_files')
        list_of_files = [x.replace(".midi", "") for x in list_of_files]
        return {"audio": list_of_files}
        
class Associate_File(Resource):
    def post(self):
        args = request.args
        rect = args["rectangle"]
        name = args["sound"]
        squares[rect] = name
        save_squares()
        return '{}', 200

api.add_resource(Color_Detection,"/color_detection")
api.add_resource(Movement_Detection,"/movement_detection")
api.add_resource(Eye_Tracking,"/eye_tracking")
api.add_resource(Receive_File, "/file")
api.add_resource(List_Files, "/list")
api.add_resource(Associate_File, "/square")

if __name__ == "__main__":
    vid = cv2.VideoCapture(0)
    ret,  imgA = vid.read()
    ret,  imgB = vid.read()
    
    squares = {}
    reload_squares()
    
    square_threads = {}
    
    app.run(debug=False)

    vid.release()
