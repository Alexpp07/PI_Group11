from time import sleep
import mediapipe as mp
import cv2
from playsound import playsound
from pygame import mixer
from midi2audio import FluidSynth

def MediaPipeHands(frame):

    mp_drawing = mp.solutions.drawing_utils
    mp_holistic = mp.solutions.holistic
    mp_hands = mp.solutions.hands

    mixer.init()
    mixer.music.set_volume(0.5)

    with mp_hands.Hands(min_detection_confidence=0.8, min_tracking_confidence=0.5) as hands:     
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
                for hand_landmarks in results.multi_hand_landmarks:
                    if (hand_landmarks.landmark[mp_hands.HandLandmark.INDEX_FINGER_TIP].y > hand_landmarks.landmark[mp_hands.HandLandmark.INDEX_FINGER_PIP].y):
                        print("SOUND1")
                        FluidSynth().play_midi('MIDI_files/g3.mid')
                        #Synthesize MIDI to audio

                        # Note: the default sound font is in 44100 Hz sample rate

                        fs = FluidSynth()
                        fs.midi_to_audio('MIDI_files/g3.mid', 'output.wav')

                        # FLAC, a lossless codec, is recommended

                        fs.midi_to_audio('MIDI_files/g3.mid', 'output.flac')
                        #mixer.Sound("./MIDI_files/g3.mid")
                        #mixer.music.play()
                    else:
                        pass
                        #print("NO")
                        #mixer.music.stop()
                    if (hand_landmarks.landmark[mp_hands.HandLandmark.MIDDLE_FINGER_TIP].y > hand_landmarks.landmark[mp_hands.HandLandmark.MIDDLE_FINGER_PIP].y):
                        print("SOUND2")
                        mixer.music.load("MIDI_files/a-3.mid")
                        mixer.music.play()
                    if (hand_landmarks.landmark[mp_hands.HandLandmark.RING_FINGER_TIP].y > hand_landmarks.landmark[mp_hands.HandLandmark.RING_FINGER_PIP].y):
                        print("SOUND3")
                        mixer.music.load("MIDI_files/c4.mid")
                        mixer.music.play()
                    if (hand_landmarks.landmark[mp_hands.HandLandmark.PINKY_TIP].y > hand_landmarks.landmark[mp_hands.HandLandmark.PINKY_PIP].y):
                        print("SOUND4")
                        mixer.music.load("MIDI_files/b5.mid")
                        mixer.music.play()
                """for hand_landmarks in results.multi_hand_landmarks:
                    print('hand_landmarks:', hand_landmarks)
                    print(
                    f'Index finger tip coordinates: (',
                    f'{hand_landmarks.landmark[mp_hands.HandLandmark.INDEX_FINGER_TIP].x}, '
                    f'{hand_landmarks.landmark[mp_hands.HandLandmark.INDEX_FINGER_TIP].y})'
                    )"""
            
            # Rendering results
            if results.multi_hand_landmarks:
                for num, hand in enumerate(results.multi_hand_landmarks):
                    mp_drawing.draw_landmarks(image, hand, mp_hands.HAND_CONNECTIONS, 
                                            mp_drawing.DrawingSpec(color=(121, 22, 76), thickness=2, circle_radius=4),
                                            mp_drawing.DrawingSpec(color=(250, 44, 250), thickness=2, circle_radius=2),
                                            )
            return frame