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

def MediaPipeHands(frame, s1, s2, s3, s4):

    mp_hands = mp.solutions.hands

    devices = AudioUtilities.GetSpeakers()
    interface = devices.Activate(IAudioEndpointVolume._iid_, CLSCTX_ALL, None)
    volume = cast(interface, POINTER(IAudioEndpointVolume))
    mixer.init()
    mixer.music.set_volume(0.5)

    with mp_hands.Hands(min_detection_confidence=0.5,  max_num_hands=2, min_tracking_confidence=0.5) as hands:     

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
                    if len(results.multi_handedness) == 2:
                        count = 0
                        for hand_landmarks in results.multi_hand_landmarks:
                            count += 1
                            if count == 2 and (hand_landmarks.landmark[mp_hands.HandLandmark.INDEX_FINGER_TIP].y > hand_landmarks.landmark[mp_hands.HandLandmark.INDEX_FINGER_PIP].y):
                                if (s1 != ""):
                                    mixer.Sound.play(mixer.Sound("WAV_files/" + s1))
                            if count == 2 and (hand_landmarks.landmark[mp_hands.HandLandmark.MIDDLE_FINGER_TIP].y > hand_landmarks.landmark[mp_hands.HandLandmark.MIDDLE_FINGER_PIP].y):
                                if (s2 != ""):
                                    mixer.Sound.play(mixer.Sound("WAV_files/" + s2))
                            if count == 2 and (hand_landmarks.landmark[mp_hands.HandLandmark.RING_FINGER_TIP].y > hand_landmarks.landmark[mp_hands.HandLandmark.RING_FINGER_PIP].y):
                                if (s3 != ""):
                                    mixer.Sound.play(mixer.Sound("WAV_files/" + s3))
                            if count == 2 and (hand_landmarks.landmark[mp_hands.HandLandmark.PINKY_TIP].y > hand_landmarks.landmark[mp_hands.HandLandmark.PINKY_PIP].y):
                                if (s4 != ""):
                                    mixer.Sound.play(mixer.Sound("WAV_files/" + s4))
                                        
                            if count == 1:
                                    x1, y1 = hand_landmarks.landmark[mp_hands.HandLandmark.INDEX_FINGER_TIP].x, hand_landmarks.landmark[mp_hands.HandLandmark.INDEX_FINGER_TIP].y
                                    x2, y2 = hand_landmarks.landmark[mp_hands.HandLandmark.THUMB_TIP].x, hand_landmarks.landmark[mp_hands.HandLandmark.THUMB_TIP].y
                                    length = hypot(x2 - x1, y2 - y1)
                                    vol = (length*3*65.25)-65.25
                                    if vol > 0:
                                        vol = 0
                                    elif vol < -65.25:
                                        vol = -65.25
                                    print(vol)
                                    volume.SetMasterVolumeLevel(vol, None)
                    else:
                        for hand_landmarks in results.multi_hand_landmarks:
                            if label == 'Left':
                                    if (hand_landmarks.landmark[mp_hands.HandLandmark.INDEX_FINGER_TIP].y > hand_landmarks.landmark[mp_hands.HandLandmark.INDEX_FINGER_PIP].y):
                                        if (s1 != ""):
                                            mixer.Sound.play(mixer.Sound("WAV_files/" + s1))
                                    if (hand_landmarks.landmark[mp_hands.HandLandmark.MIDDLE_FINGER_TIP].y > hand_landmarks.landmark[mp_hands.HandLandmark.MIDDLE_FINGER_PIP].y):
                                        if (s2 != ""):
                                            mixer.Sound.play(mixer.Sound("WAV_files/" + s2))
                                    if (hand_landmarks.landmark[mp_hands.HandLandmark.RING_FINGER_TIP].y > hand_landmarks.landmark[mp_hands.HandLandmark.RING_FINGER_PIP].y):
                                        if (s3 != ""):
                                            mixer.Sound.play(mixer.Sound("WAV_files/" + s3))
                                    if (hand_landmarks.landmark[mp_hands.HandLandmark.PINKY_TIP].y > hand_landmarks.landmark[mp_hands.HandLandmark.PINKY_PIP].y):
                                        if (s4 != ""):
                                            mixer.Sound.play(mixer.Sound("WAV_files/" + s4))
                                        
                            if label == 'Right':
                                    x1, y1 = hand_landmarks.landmark[mp_hands.HandLandmark.INDEX_FINGER_TIP].x, hand_landmarks.landmark[mp_hands.HandLandmark.INDEX_FINGER_TIP].y
                                    x2, y2 = hand_landmarks.landmark[mp_hands.HandLandmark.THUMB_TIP].x, hand_landmarks.landmark[mp_hands.HandLandmark.THUMB_TIP].y
                                    length = hypot(x2 - x1, y2 - y1)
                                    vol = (length*3*65.25)-65.25
                                    if vol > 0:
                                        vol = 0
                                    elif vol < -65.25:
                                        vol = -65.25
                                    print(vol)
                                    volume.SetMasterVolumeLevel(vol, None)
            return frame

def MediaPipe2Hands(frame, s1, s2, s3, s4, s5, s6, s7, s8):

    mp_hands = mp.solutions.hands
    mixer.init()
    mixer.music.set_volume(0.5)

    with mp_hands.Hands(min_detection_confidence=0.5,  max_num_hands=2, min_tracking_confidence=0.5) as hands:     

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
                        if len(results.multi_handedness) == 2:
                            count = 0
                            for hand_landmarks in results.multi_hand_landmarks:
                                count += 1
                                if count == 2 and (hand_landmarks.landmark[mp_hands.HandLandmark.INDEX_FINGER_TIP].y > hand_landmarks.landmark[mp_hands.HandLandmark.INDEX_FINGER_PIP].y):
                                    if (s1 != ""):
                                        mixer.Sound.play(mixer.Sound("WAV_files/" + s1))
                                if count == 2 and (hand_landmarks.landmark[mp_hands.HandLandmark.MIDDLE_FINGER_TIP].y > hand_landmarks.landmark[mp_hands.HandLandmark.MIDDLE_FINGER_PIP].y):
                                    if (s2 != ""):
                                        mixer.Sound.play(mixer.Sound("WAV_files/" + s2))                                       
                                if count == 2 and (hand_landmarks.landmark[mp_hands.HandLandmark.RING_FINGER_TIP].y > hand_landmarks.landmark[mp_hands.HandLandmark.RING_FINGER_PIP].y):
                                    if (s3 != ""):
                                        mixer.Sound.play(mixer.Sound("WAV_files/" + s3))                                      
                                if count == 2 and (hand_landmarks.landmark[mp_hands.HandLandmark.PINKY_TIP].y > hand_landmarks.landmark[mp_hands.HandLandmark.PINKY_PIP].y):
                                    if (s4 != ""):
                                        mixer.Sound.play(mixer.Sound("WAV_files/" + s4))
                                        
                                        
                                if count == 1 and (hand_landmarks.landmark[mp_hands.HandLandmark.INDEX_FINGER_TIP].y > hand_landmarks.landmark[mp_hands.HandLandmark.INDEX_FINGER_PIP].y):
                                    if (s5 != ""):
                                        mixer.Sound.play(mixer.Sound("WAV_files/" + s5))                                
                                if count == 1 and (hand_landmarks.landmark[mp_hands.HandLandmark.MIDDLE_FINGER_TIP].y > hand_landmarks.landmark[mp_hands.HandLandmark.MIDDLE_FINGER_PIP].y):
                                    if (s6 != ""):
                                        mixer.Sound.play(mixer.Sound("WAV_files/" + s6))
                                if count == 1 and (hand_landmarks.landmark[mp_hands.HandLandmark.RING_FINGER_TIP].y > hand_landmarks.landmark[mp_hands.HandLandmark.RING_FINGER_PIP].y):
                                    if (s7 != ""):
                                        mixer.Sound.play(mixer.Sound("WAV_files/" + s7))                                       
                                if count == 1 and (hand_landmarks.landmark[mp_hands.HandLandmark.PINKY_TIP].y > hand_landmarks.landmark[mp_hands.HandLandmark.PINKY_PIP].y):
                                    if (s8 != ""):
                                        mixer.Sound.play(mixer.Sound("WAV_files/" + s8))
                                        
                        else:
                            for hand_landmarks in results.multi_hand_landmarks:
                                if label == 'Left':
                                    if (hand_landmarks.landmark[mp_hands.HandLandmark.INDEX_FINGER_TIP].y > hand_landmarks.landmark[mp_hands.HandLandmark.INDEX_FINGER_PIP].y):
                                        if (s1 != ""):
                                            print(">>>>>>>>>" + label + s1)
                                            mixer.Sound.play(mixer.Sound("WAV_files/" + s1))
                                    if (hand_landmarks.landmark[mp_hands.HandLandmark.MIDDLE_FINGER_TIP].y > hand_landmarks.landmark[mp_hands.HandLandmark.MIDDLE_FINGER_PIP].y):
                                        if (s2 != ""):
                                            mixer.Sound.play(mixer.Sound("WAV_files/" + s2))
                                    if (hand_landmarks.landmark[mp_hands.HandLandmark.RING_FINGER_TIP].y > hand_landmarks.landmark[mp_hands.HandLandmark.RING_FINGER_PIP].y):
                                        if (s3 != ""):
                                            mixer.Sound.play(mixer.Sound("WAV_files/" + s3))
                                    if (hand_landmarks.landmark[mp_hands.HandLandmark.PINKY_TIP].y > hand_landmarks.landmark[mp_hands.HandLandmark.PINKY_PIP].y):
                                        if (s4 != ""):
                                            mixer.Sound.play(mixer.Sound("WAV_files/" + s4))
                                            
                                elif label == 'Right':
                                    if (hand_landmarks.landmark[mp_hands.HandLandmark.INDEX_FINGER_TIP].y > hand_landmarks.landmark[mp_hands.HandLandmark.INDEX_FINGER_PIP].y):
                                        if (s5 != ""):
                                            print(">>>>>>>>>" + label + s5)
                                            mixer.Sound.play(mixer.Sound("WAV_files/" + s5))
                                    if (hand_landmarks.landmark[mp_hands.HandLandmark.MIDDLE_FINGER_TIP].y > hand_landmarks.landmark[mp_hands.HandLandmark.MIDDLE_FINGER_PIP].y):
                                        if (s6 != ""):
                                            mixer.Sound.play(mixer.Sound("WAV_files/" + s6))
                                    if (hand_landmarks.landmark[mp_hands.HandLandmark.RING_FINGER_TIP].y > hand_landmarks.landmark[mp_hands.HandLandmark.RING_FINGER_PIP].y):
                                        if (s7 != ""):
                                            mixer.Sound.play(mixer.Sound("WAV_files/" + s7))
                                    if (hand_landmarks.landmark[mp_hands.HandLandmark.PINKY_TIP].y > hand_landmarks.landmark[mp_hands.HandLandmark.PINKY_PIP].y):
                                        if (s8 != ""):
                                            mixer.Sound.play(mixer.Sound("WAV_files/" + s8))
                        
                                

                        
            
            return frame