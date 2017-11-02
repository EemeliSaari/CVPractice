import os
import time

import cv2
import matplotlib.pyplot as plt
import numpy as np


def main():

    path = './images/series/series1/'
    start = time.time()
    images_list = []

    for file in os.listdir(path):

        if file.split('.')[1] == 'JPG':
            img = cv2.imread(path + file.split('.')[0] + '.jpg', 1)
            gray = cv2.cvtColor(img, cv2.COLOR_BGR2GRAY)
            images_list.append([img, gray])

    fast = cv2.FastFeatureDetector_create(threshold=50,nonmaxSuppression=50)
    for count,i in enumerate(images_list):
        print(count)
        plt.figure(count)

        kp = fast.detect(i[1],None)
        img2 = cv2.drawKeypoints(i[0], kp, None, color=(255,0,0)) 
        
        display = cv2.cvtColor(img2,cv2.COLOR_BGR2RGB)
        plt.imshow(display,cmap='gray')
    
    print('loop took {} seconds'.format(time.time()-start))
    
    #plt.show()


main()
