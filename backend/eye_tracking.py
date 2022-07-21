"""
Demonstration of the GazeTracking library.
Check the README.md for complete documentation.
"""

import cv2

from gaze_tracking import GazeTracking

def EyeTracking(frame,gaze, gazeBounds):
    #send frame to gaze module
    gaze.refresh(frame)
    verticalR = gaze.vertical_ratio()
    horizontalR = gaze.horizontal_ratio()
    if verticalR and horizontalR:
        if gazeBounds[0] > verticalR:
            gazeBounds[0] = verticalR
        if gazeBounds[2] < verticalR:
            gazeBounds[2] = verticalR
        if gazeBounds[1] > horizontalR:
            gazeBounds[1] = horizontalR
        if gazeBounds[3] < horizontalR:
            gazeBounds[3] = horizontalR
        verticalR = (verticalR - gazeBounds[0]) / (gazeBounds[2] - gazeBounds[0])
        horizontalR = (horizontalR - gazeBounds[1]) / (gazeBounds[3] - gazeBounds[1])
        hor = frame.shape[1] * horizontalR
        ver = frame.shape[0] * verticalR
        return frame, (hor, ver), gazeBounds
    return frame, (None, None), gazeBounds




