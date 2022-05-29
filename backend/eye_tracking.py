"""
Demonstration of the GazeTracking library.
Check the README.md for complete documentation.
"""

import cv2

from gaze_tracking import GazeTracking

def EyeTracking(frame):
    gaze = GazeTracking()

    minV = 0.4
    minH = 0.4
    maxV = 0.7
    maxH = 0.7

    # We send this frame to GazeTracking to analyze it
    gaze.refresh(frame)

    verticalR = gaze.vertical_ratio()
    horizontalR = gaze.horizontal_ratio()

    if verticalR and horizontalR:
        if minV > verticalR:
            minV = verticalR
        if maxV < verticalR:
            maxV = verticalR
        if minH > horizontalR:
            minH = horizontalR
        if maxH < horizontalR:
            maxH = horizontalR

        verticalR = (verticalR - minV) / (maxV - minV)
        horizontalR = (horizontalR - minH) / (maxH - minH)

        hor = frame.shape[1] * horizontalR
        ver = frame.shape[0] * verticalR
        return frame
    return frame




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
