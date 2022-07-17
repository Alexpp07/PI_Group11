from msilib.schema import Media
from operator import index
import os
from math import ceil

import cv2
from os.path import exists
from MovementDetection import MovementDetection
from ColorDetection import ColorDetection
from MediaPipeHands import MediaPipeHandsFingers
from eye_tracking import EyeTracking
from gaze_tracking import GazeTracking
from MediaPipeHands import MediaPipeHands
import numpy as np
import io
import base64
import threading
import pygame
import json
from time import sleep
import mediapipe as mp
import cv2
from playsound import playsound
from pygame import mixer

from flask import Flask, request, Response
from flask_restful import Api, Resource
from flask_cors import CORS
import time
from waitress import serve
from MediaPipeHands import MediaPipeHands


'''
app = Flask(__name__)
api = CORS(app)
api = Api(app)
'''

def image():
    global imgA
    global imgB
    global vid
    imgB = imgA
    ret,imgA = vid.read()
    return imgA
    
#def play_sound(name):
#    clock = pygame.time.Clock()
#    pygame.mixer.init()
#    pygame.mixer.music.load("./MIDI_files/" + name + ".mid")
#    pygame.mixer.music.play(0)
#    while pygame.mixer.music.get_busy():
#        clock.tick(30) # check if playback has finished
    
def prepareResult(frame, grid_size, coords):
    
    global square_threads
    global previous_square
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
            if not squareX <= coords[0] < squareX + dx:
                squareX += dx
                stopped = False
            else:
                stopped = True
            if not squareY <= coords[1] < squareY + dy:
                squareY += dy
                stopped = False
        temp_copy = cv2.rectangle(temp_copy, (int(squareX), int(squareY)), (int(squareX + dx), int(squareY + dy)), (100, 100,100), -1)
        cv2.addWeighted(frame, 0.5, temp_copy, 0.5, 0, frame)
        
        x = int(coords[0])
        y = int(coords[1])
        frame = cv2.circle(frame, (x, y), radius=5, color=(255, 0, 0), thickness=-1)
        
        Xs = round(squareX/dx)
        Ys = round(squareY/dy)

        
        square = Ys * column + Xs
        global squares
        if square != previous_square and str(square) in squares.keys():
            filename = squares[str(square)]
            if filename != None and square_threads[str(square)].get_busy() == False:
                sound = pygame.mixer.Sound("./MIDI_files/" + filename + ".mid")
                square_threads[str(square)].play(sound)
        previous_square = square
    else:
        previous_square = 0
        
    with open("file.jpg", "wb") as dest:
        jpg = cv2.imencode(".jpg", frame)[1]
        dest.write(jpg)
    image = open("file.jpg", "rb")
    return {"data": str(base64.b64encode(image.read()))}

def prepareResultMediaPipeHands(frame, coords):
    
    global square_threads
    global previous_square

    if coords[0] != None and coords[1] != None:
        temp_copy = frame.copy()
        squareX = 0
        squareY = 0
        stopped = False
        #figure out which square should be highlighted
        
        x = int(coords[0])
        y = int(coords[1])
        frame = cv2.circle(frame, (x, y), radius=5, color=(255, 0, 0), thickness=-1)
        
        
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
            squares[str(i+1)] = midi
    
def save_squares():
    global squares
    f = open("save.txt","w")
    for i in range(16):
        if str(i+1) in squares.keys() and squares[str(i+1)] != None:
            f.write(squares[str(i+1)] + "\n")
        else:
            f.write("\n")
    f.close()

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
        global gaze
        global gazeBounds
        args = request.args
        rect = int(args["rectangles"])
        img = image()
        frame, coords, gazeBounds = EyeTracking(img,gaze, gazeBounds)
        result = prepareResult(frame, rect, coords)
        return result
        
class Receive_File(Resource):
    def post(self):
        args = request.form
        midifile = args["file"]
        name = args["name"]
        midifile = midifile[2:len(midifile)-1]
        midifile = bytes(midifile, 'utf-8')
        midifile = base64.b64decode(midifile)
        writeout = open("./MIDI_files/" + name + ".mid", "wb")
        writeout.write(midifile)
        return '{}', 200
        
class List_Files(Resource):
    def get(self):
        list_of_files = os.listdir('./MIDI_files')
        list_of_files = [x.replace(".midi", "") for x in list_of_files]
        return {"audio": list_of_files}
        
class Associate_File(Resource):
    def post(self):
        args = json.loads(request.data)
        rect = args["rectangle"]
        name = args["sound"]
        squares[rect] = name
        save_squares()
        return '{}', 200

class MediaPipe_Hands(Resource):
    finger1 = ""
    finger2 = ""
    finger3 = ""
    finger4 = ""

    dic = {"finger1":finger1, "finger2":finger2, "finger3": finger3, "finger4":finger4}

    def get(self):
        args = request.args
        rect = int(args["rectangles"])
        img = image()
        frame = MediaPipeHands(img, self.dic["finger1"], self.dic["finger2"], self.dic["finger3"], self.dic["finger4"])
        result = prepareResultMediaPipeHands(frame, [0,0])
        return result

    def post(self):
         args = json.loads(request.data)
         sound = args["sound"]
         s1 = sound[0]
         s2 = sound[1]
         s3 = sound[2]
         s4 = sound[3]
         self.setFingerSound(s1, s2, s3, s4)
         return self.finger1

    def setFingerSound(self, s1, s2, s3, s4):
        self.dic["finger1"] = s1
        self.dic["finger2"] = s2
        self.dic["finger3"] = s3
        self.dic["finger4"] = s4

def create_app():
    global vid
    global imgA
    global imgB
    global squares
    global square_threads
    global gaze
    global gazeBounds
    global previous_square
    
    previous_square = 0

    gaze = GazeTracking()
    gazeBounds = [0.4, 0.4, 0.7, 0.7]
    
    pygame.mixer.init(size=32)
    pygame.mixer.set_num_channels(16)

    vid = cv2.VideoCapture(0)
    ret, imgA = vid.read()
    ret, imgB = vid.read()

    squares = {}
    reload_squares()
    square_threads = {str(x+1):pygame.mixer.Channel(x) for x in range(16)}

    app = Flask(__name__)
    api = CORS(app)
    api = Api(app)

    api.add_resource(Color_Detection, "/color_detection")
    api.add_resource(Movement_Detection, "/movement_detection")
    api.add_resource(Eye_Tracking, "/eye_tracking")
    api.add_resource(MediaPipe_Hands, "/mediapipe_hands")
    api.add_resource(Receive_File, "/file")
    api.add_resource(List_Files, "/list")
    api.add_resource(Associate_File, "/square")
    #api.add_resource(Index_Finger, "/index_finger")

    #app.run(debug=False)
    serve(app, host='127.0.0.1', port=5000, threads=4)
    vid.release()

create_app()
''' 
if __name__ == "__main__":
    vid = cv2.VideoCapture(0)
    ret,  imgA = vid.read()
    ret,  imgB = vid.read()
    
    squares = {}
    reload_squares()
    square_threads = {}
    
    app.run(debug=False)

    vid.release()
'''
