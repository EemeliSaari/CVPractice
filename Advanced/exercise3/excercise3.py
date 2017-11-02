import cv2
import matplotlib.pyplot as plt
import numpy as np

# Purpose of this excercise was to learn how and why to apply filters to the image.
# Topics also included correcting the uneven illumination using morphology and doing
# simple blob analysis.

def add_gaussian(image):
    """
    Adds a gaussian noise to the grayscale image.

    :param image: grayscale image
    :return: image with noise.
    """
    
    mean = 0
    var = 30
    
    gauss = np.random.normal(mean,var, image.shape)
    noisy = image + gauss 

    return noisy


def regionprobs(bw,img):
    """
    Measures of properties of images contours and highlights them into the
    displayed image.

    :param bw: binary threshold image
    :param img: image we want to draw rectangles into.
    """
    
    # finding the contours and only returns the outer contours.
    # we only use contours and ignore hierarchy and bw2.
    bw2, contours, hierarchy = cv2.findContours(bw, cv2.RETR_TREE, cv2.CHAIN_APPROX_NONE)

    # handle every contour individualy with a for loop.
    for cnt in contours:
        # takes the Area of the contour 
       if len(cnt) > 5:
            m = cv2.moments(cnt)
            area = m['m00']
            
            # 0 value contours can cause problems
            if area > float(0):
                # Centroid, (Major Axis, minor axis), orientation
                (x, y), (maxa, mina), angle = cv2.fitEllipse(cnt)

                if 155 > area > 5 and 0 < angle > 90:
                    # finds a minimum area enclosing the 2D point set much like
                    # matlabs BoundingBox param
                    rect = cv2.minAreaRect(cnt)
                    # makes a np array of the 4 vertices of a rotated rectangle
                    box = np.int0(cv2.boxPoints(rect))
                    
                    # draws them on the given image
                    cv2.drawContours(img,[box],0,(140,23,255),1)


def main():

    # path to the image
    path = './images/png/rice.png'
    
    # to display the steps along the way use plt.imshow(image) and plt.show()

    # opens and converts the color to RGB from BGR
    original = cv2.cvtColor(cv2.imread(path, 1),cv2.COLOR_BGR2RGB)

    # makes a grayscale image of the original
    gray = cv2.cvtColor(original,cv2.COLOR_RGB2GRAY)
    
    # adds the gaussian noise
    gauss = add_gaussian(gray)
    
    # blurs the image using GaussianBlur
    blur = cv2.GaussianBlur(gauss, (15,15), 3)
    
    # uses morphological method called top hat to filter out the 
    # background.
    kernel = np.ones((15,15),np.uint8)
    opening = cv2.morphologyEx(blur,cv2.MORPH_TOPHAT,kernel)
    
    # makes a threshold within the given range
    threshold = cv2.inRange(opening,41,58)

    # applies the detection function to the thresholded image.
    regionprobs(threshold,original)

    plt.imshow(original)
    plt.show()


if __name__ == "__main__":
    main()
