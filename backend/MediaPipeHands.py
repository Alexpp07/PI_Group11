from operator import index
from time import sleep
import mediapipe as mp
import cv2
from playsound import playsound
from pygame import mixer
from google.protobuf.json_format import MessageToDict
from ctypes import cast, POINTER
from comtypes import CLSCTX_ALL
from pycaw.pycaw import AudioUtilities, IAudioEndpointVolume
from ctypes import cast, POINTER
import numpy as np
from math import hypot
from flask import Flask, request, Response
import json

def MediaPipeHands(frame, sound):

    mp_drawing = mp.solutions.drawing_utils
    mp_holistic = mp.solutions.holistic
    mp_hands = mp.solutions.hands

    devices = AudioUtilities.GetSpeakers()
    interface = devices.Activate(IAudioEndpointVolume._iid_, CLSCTX_ALL, None)
    volume = cast(interface, POINTER(IAudioEndpointVolume))
    volMin, volMax = volume.GetVolumeRange()[:2]

    fingers = []

    mixer.init()
    mixer.music.set_volume(0.5)

    with mp_hands.Hands(min_detection_confidence=0.5,  max_num_hands=1, min_tracking_confidence=0.5) as hands:     

            # BGR 2 RGB
            image = cv2.cvtColor(frame, cv2.COLOR_BGR2RGB)
            
            # Flip on horizontal
            image = cv2.flip(image, 1)
            
            # Set flag
            image.flags.writeable = False
            
            # Detections
            results = hands.process(image)
            
            # Set flag to true
            image.flags.writeable = True
            
            # RGB 2 BGR
            image = cv2.cvtColor(image, cv2.COLOR_RGB2BGR)
            
            # Detections
            # print(results.toString)

            if results.multi_hand_landmarks:

                for i in results.multi_handedness:
                    label = MessageToDict(i)['classification'][0]['label']

                    if label == 'Left':
                        for hand_landmarks in results.multi_hand_landmarks:
                            if (hand_landmarks.landmark[mp_hands.HandLandmark.INDEX_FINGER_TIP].y > hand_landmarks.landmark[mp_hands.HandLandmark.INDEX_FINGER_PIP].y):
                                if (sound == "None"):
                                    print(">>>>NOT PLAYING, FODA-SE: ") 
                                else: 
                                    print(">>>>PLAYING: ", sound) 
                                    mixer.Sound.play(mixer.Sound(sound))
                            if (hand_landmarks.landmark[mp_hands.HandLandmark.MIDDLE_FINGER_TIP].y > hand_landmarks.landmark[mp_hands.HandLandmark.MIDDLE_FINGER_PIP].y):
                                mixer.Sound.play(mixer.Sound('WAV_files/a4.wav'))
                            if (hand_landmarks.landmark[mp_hands.HandLandmark.RING_FINGER_TIP].y > hand_landmarks.landmark[mp_hands.HandLandmark.RING_FINGER_PIP].y):
                                mixer.Sound.play(mixer.Sound('WAV_files/b4.wav'))
                            if (hand_landmarks.landmark[mp_hands.HandLandmark.PINKY_TIP].y > hand_landmarks.landmark[mp_hands.HandLandmark.PINKY_PIP].y):
                                mixer.Sound.play(mixer.Sound('WAV_files/c4.wav'))
                    if label == 'Right':
                        for hand_landmarks in results.multi_hand_landmarks:
                            x1, y1 = hand_landmarks.landmark[mp_hands.HandLandmark.INDEX_FINGER_TIP].x, hand_landmarks.landmark[mp_hands.HandLandmark.INDEX_FINGER_TIP].y
                            x2, y2 = hand_landmarks.landmark[mp_hands.HandLandmark.THUMB_TIP].x, hand_landmarks.landmark[mp_hands.HandLandmark.THUMB_TIP].y
                            length = hypot(x2 - x1, y2 - y1)
                            vol = (length*3*65.25)-65.25
                            if vol > 0:
                                vol = 0
                            # volumeValue = np.interp(length, [50, 250], [-65.25, 0.0]) #coverting length to proportionate to volume range
                            print(vol)
                            volume.SetMasterVolumeLevel(vol, None)
                
            # Rendering results
            if results.multi_hand_landmarks:
                for num, hand in enumerate(results.multi_hand_landmarks):
                    mp_drawing.draw_landmarks(image, hand, mp_hands.HAND_CONNECTIONS, 
                                            mp_drawing.DrawingSpec(color=(121, 22, 76), thickness=2, circle_radius=4),
                                            mp_drawing.DrawingSpec(color=(250, 44, 250), thickness=2, circle_radius=2),
                                            )
            return frame

def MediaPipeHandsFingers(frame):

    mp_drawing = mp.solutions.drawing_utils
    mp_holistic = mp.solutions.holistic
    mp_hands = mp.solutions.hands

    devices = AudioUtilities.GetSpeakers()
    interface = devices.Activate(IAudioEndpointVolume._iid_, CLSCTX_ALL, None)
    volume = cast(interface, POINTER(IAudioEndpointVolume))
    volMin, volMax = volume.GetVolumeRange()[:2]

    fingers = []

    mixer.init()
    mixer.music.set_volume(0.5)

    with mp_hands.Hands(min_detection_confidence=0.5,  max_num_hands=1, min_tracking_confidence=0.5) as hands:     

            # BGR 2 RGB
            image = cv2.cvtColor(frame, cv2.COLOR_BGR2RGB)
            
            # Flip on horizontal
            image = cv2.flip(image, 1)
            
            # Set flag
            image.flags.writeable = False
            
            # Detections
            results = hands.process(image)
            
            # Set flag to true
            image.flags.writeable = True
            
            # RGB 2 BGR
            image = cv2.cvtColor(image, cv2.COLOR_RGB2BGR)
            
            # Detections
            # print(results.toString)

            if results.multi_hand_landmarks:

                for i in results.multi_handedness:
                    label = MessageToDict(i)['classification'][0]['label']
                    index_finger = mp_hands.HandLandmark.INDEX_FINGER_TIP
                    fingers.append(index_finger)
                    print(">>>CHEGUEI AQUI")

                    if label == 'Left':
                        for hand_landmarks in results.multi_hand_landmarks:
                            if (hand_landmarks.landmark[mp_hands.HandLandmark.INDEX_FINGER_TIP].y > hand_landmarks.landmark[mp_hands.HandLandmark.INDEX_FINGER_PIP].y):
                                mixer.Sound.play(mixer.Sound('WAV_files/g3.wav'))
                            if (hand_landmarks.landmark[mp_hands.HandLandmark.MIDDLE_FINGER_TIP].y > hand_landmarks.landmark[mp_hands.HandLandmark.MIDDLE_FINGER_PIP].y):
                                mixer.Sound.play(mixer.Sound('WAV_files/a4.wav'))
                            if (hand_landmarks.landmark[mp_hands.HandLandmark.RING_FINGER_TIP].y > hand_landmarks.landmark[mp_hands.HandLandmark.RING_FINGER_PIP].y):
                                mixer.Sound.play(mixer.Sound('WAV_files/b4.wav'))
                            if (hand_landmarks.landmark[mp_hands.HandLandmark.PINKY_TIP].y > hand_landmarks.landmark[mp_hands.HandLandmark.PINKY_PIP].y):
                                mixer.Sound.play(mixer.Sound('WAV_files/c4.wav'))
                    if label == 'Right':
                        for hand_landmarks in results.multi_hand_landmarks:
                            x1, y1 = hand_landmarks.landmark[mp_hands.HandLandmark.INDEX_FINGER_TIP].x, hand_landmarks.landmark[mp_hands.HandLandmark.INDEX_FINGER_TIP].y
                            x2, y2 = hand_landmarks.landmark[mp_hands.HandLandmark.THUMB_TIP].x, hand_landmarks.landmark[mp_hands.HandLandmark.THUMB_TIP].y
                            length = hypot(x2 - x1, y2 - y1)
                            vol = (length*3*65.25)-65.25
                            if vol > 0:
                                vol = 0
                            # volumeValue = np.interp(length, [50, 250], [-65.25, 0.0]) #coverting length to proportionate to volume range
                            print(vol)
                            volume.SetMasterVolumeLevel(vol, None)
                
            # Rendering results
            if results.multi_hand_landmarks:
                for num, hand in enumerate(results.multi_hand_landmarks):
                    mp_drawing.draw_landmarks(image, hand, mp_hands.HAND_CONNECTIONS, 
                                            mp_drawing.DrawingSpec(color=(121, 22, 76), thickness=2, circle_radius=4),
                                            mp_drawing.DrawingSpec(color=(250, 44, 250), thickness=2, circle_radius=2),
                                            )
            print(">>>>> MEDIAPIPEHANDS - FINGERS:", fingers)
            return fingers