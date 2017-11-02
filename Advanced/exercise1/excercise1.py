import sys
sys.path.append('./toolkit/')


import cv2
import matplotlib.pyplot as plt
import numpy as np
from PIL import Image

import draw_functions

# This excercise purpose was to detect colored chips in the coloredChips.png image as 
# well as to do the detection when the illumination was artificially modified. Point was
# to learn the basic image processing methods that Python had to offer and to learn some
# methods of OpenCV.

def detect_color(image,boundary,min_area):
    """
    OpenCV simpleblobdetector to detect areas of similiar color.

    :param image: rgb image
    :param boundary: threshold boundaries
    :param min_area: parameter for blob detector
    """

    gray = cv2.cvtColor(image,cv2.COLOR_RGB2GRAY)
    params = cv2.SimpleBlobDetector_Params()

    # only looking at certain sized blobs
    params.filterByArea = 1
    params.minArea = min_area

    # only looks at the white blobs
    params.filterByColor = 1
    params.blobColor = 255

    # eases the convexity of the blob to allow inperfect shapes
    params.filterByConvexity = 1
    params.minConvexity = 0.2

    # Set up the detector with default parameters.
    detector = cv2.SimpleBlobDetector_create(params)
    
    # sets the threshold according to boundaries
    threshold = cv2.inRange(gray,boundary[0],boundary[1])
    
    # Detect blobs.
    keypoints = detector.detect(threshold)
    
    # Draws crosses at the center of detected blob
    
    return keypoints

def draw_keypoints(img,keypoints):
    """
    Draws keypoints found to the image

    :param img: image that the keypoints will be drawn into
    :param keypoints: list of keypoints
    :return: image
    """
    for i in keypoints:
        x,y = int(i.pt[0]),int(i.pt[1])
        draw_functions.cross((x,y),50,img)

    return img

def normalize_image(img):
    """
    Normalizes the image

    :param img: rgba img
    :return: normalized image
    """
    
    rgb = cv2.cvtColor(img,cv2.COLOR_RGBA2RGB)

    # creates two identical 'white' pictures
    norm = np.zeros(img.shape,dtype=np.float32)
    norm_rgb = np.zeros(img.shape,dtype=np.uint8)

    # reads the b g r values from rgb picture
    r = rgb[:,:,0]
    g = rgb[:,:,1]
    b = rgb[:,:,2]

    # counts the total value
    total = b + g + r

    # normalizes every value and sets values based on example: r' = r/total * 255.0
    np.seterr(divide='ignore', invalid='ignore')
    norm[:,:,0] = r/total * 255.0
    norm[:,:,1] = g/total * 255.0
    norm[:,:,2] = b/total * 255.0
    norm_rgb = cv2.cvtColor(cv2.convertScaleAbs(norm),cv2.COLOR_RGBA2RGB)

    return norm_rgb


def main():

    # Reads the image with opencv
    # -1 meaning unchanged
    #  0 meaning grayscale
    #  1 meaning colored
    # output image is numpy array in a format BlueGreenRed that we convert into RGB
    original = cv2.cvtColor(cv2.imread('./images/png/coloredChips.png',1),cv2.COLOR_BGR2RGB)
    
    # makes two copies of them
    img_1 = original.copy()
    img_2 = original.copy()
    
    # converts the image to grayscale image
    gray = cv2.cvtColor(img_1,cv2.COLOR_RGB2GRAY)
    
    # makes a gradient filter to the image
    pil_img = draw_functions.gradient(path='./images/png/coloredChips.png',gradient_magnitude=2.)
    # gradient image is done with pythons PIL library so we have to convert it to numpy array
    gradient_img = np.array(pil_img)

    # awkwardly show all of the images separately
    # matplotlib imshow displays the images as RGB. 
    plt.imshow(original)
    plt.show()
    plt.hist(x=gray.ravel(), bins='auto', histtype='stepfilled')
    plt.show()
    plt.imshow(draw_keypoints(img_1,detect_color(img_2,(55,73),100)))
    plt.show()
    plt.imshow(draw_keypoints(img_2,detect_color(img_2,(218,230),130)))
    plt.show()
    plt.imshow(draw_keypoints(gradient_img,detect_color(normalize_image(gradient_img),(180,189),150)))
    plt.show()


if __name__ == '__main__':
    main()
