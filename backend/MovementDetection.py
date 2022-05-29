import cv2
import imutils
from skimage.metrics import structural_similarity as compare_ssim
def MovementDetection(imageA, imageB):
    # convert the images to grayscale 
    grayA = cv2.cvtColor(imageA, cv2.COLOR_BGR2GRAY)
    grayB = cv2.cvtColor(imageB, cv2.COLOR_BGR2GRAY)
    # compute the Structural Similarity Index (SSIM) between the two
    # images, ensuring that the difference image is returned
    (score, diff) = compare_ssim(grayA, grayB, full=True)
    diff = (diff * 255).astype("uint8")

    # threshold the difference image, followed by finding contours to
    # obtain the regions of the two input images that differ
    thresh = cv2.threshold(diff, 0, 255,
        cv2.THRESH_BINARY_INV | cv2.THRESH_OTSU)[1]
    morph = cv2.getStructuringElement(cv2.MORPH_RECT, (5,5), (2,2)) 
    thresh = cv2.morphologyEx(thresh, cv2.MORPH_OPEN, morph)
    cnts = cv2.findContours(thresh.copy(), cv2.RETR_EXTERNAL,
    	cv2.CHAIN_APPROX_SIMPLE)
    cnts = imutils.grab_contours(cnts)

    positions = {}
    maxArea = 6000

    for c in cnts:
        if cv2.contourArea(c) < maxArea:
            (x, y, w, h) = cv2.boundingRect(c)
            positions["hor"] = x + w / 2
            positions["ver"] = y + h / 2
            maxArea = cv2.contourArea(c)

        # cv2.rectangle(image, (x, y), (x+w, y+h), (0,255,0), 2)
    # show the images
    return imageA  # np.hstack([image, output])
