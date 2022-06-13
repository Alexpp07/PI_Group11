# import the necessary packages
import numpy as np
import imutils
import cv2

boundaries = [
	([17, 15, 100], [50, 56, 200]),
	([86, 31, 4], [220, 88, 50]),
	([25, 146, 190], [62, 174, 250]),
	([103, 86, 65], [145, 133, 128])
]


def ColorDetection(image,r,b,g,threshold):
    # loop over the boundaries
    # create NumPy arrays from the boundaries
    #r = cv2.getTrackbarPos('R', 'Result')
    #g = cv2.getTrackbarPos('G', 'Result')
    #b = cv2.getTrackbarPos('B', 'Result')
    lower = np.array([max(0, r - threshold), max(0, g - threshold), max(0, b - threshold)], dtype = "uint8")
    upper = np.array([min(255, r + threshold), min(255, g + threshold), min(255, b + threshold)], dtype = "uint8")
    # find the colors within the specified boundaries and apply
    # the mask
    mask = cv2.inRange(image, lower, upper)
    #output = cv2.bitwise_and(image, image, mask = mask)
    morph = cv2.getStructuringElement(cv2.MORPH_RECT, (5,5), (2,2)) 
    mask = cv2.morphologyEx(mask, cv2.MORPH_CLOSE, morph)
    cnts = cv2.findContours(mask, cv2.RETR_EXTERNAL,
    	cv2.CHAIN_APPROX_SIMPLE)
    cnts = imutils.grab_contours(cnts)

    positions = {"hor":None, "ver":None}
    maxArea = 500

    for c in cnts:
        if cv2.contourArea(c) > maxArea:
            (x, y, w, h) = cv2.boundingRect(c)
            positions["hor"] = x + w / 2
            positions["ver"] = y + h / 2
            maxArea=cv2.contourArea(c)

        #cv2.rectangle(image, (x, y), (x+w, y+h), (0,255,0), 2)
    # show the images
    #with open("test.jpg", "wb") as dest:
    #    jpg = cv2.imencode(".jpg", mask)[1]
    #    dest.write(jpg)
    return image, (positions["hor"], positions["ver"]) #np.hstack([image, output])
