"""
Demonstration of the GazeTracking library.
Check the README.md for complete documentation.
"""

import cv2

from gaze_tracking import GazeTracking

def EyeTracking(frame,gaze, gazeBounds):
    #gaze = GazeTracking()


    # We send this frame to GazeTracking to analyze it
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




    #cv2.putText(frame, text, (90, 60), cv2.FONT_HERSHEY_DUPLEX, 1.6, (147, 58, 31), 2)

    #left_pupil = gaze.pupil_left_coords()
    #right_pupil = gaze.pupil_right_coords()
    # cv2.putText(frame, "Left pupil:  " + str(left_pupil), (90, 130), cv2.FONT_HERSHEY_DUPLEX, 0.9, (147, 58, 31), 1)
    # cv2.putText(frame, "Right pupil: " + str(right_pupil), (90, 165), cv2.FONT_HERSHEY_DUPLEX, 0.9, (147, 58, 31), 1)

    #cv2.putText(frame, "Vertical Ratio:  " + str(verticalR) , (90, 165),               cv2.FONT_HERSHEY_DUPLEX, 0.9, (147, 58, 31), 1, )
    #cv2.putText(frame, "Horizontal Ratio:  " + str(horizontalR) , (90, 200), cv2.FONT_HERSHEY_DUPLEX, 0.9, (147, 58, 31), 1, )

    #cv2.imshow("Demo", frame)

    #if cv2.waitKey(1) == ord('q'):
    #    break

#webcam.release()
#cv2.destroyAllWindows()
