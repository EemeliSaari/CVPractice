import cv2
import matplotlib.pyplot as plt
import numpy as np
import math
from PIL import Image

def cross(center_point,area,image):
    """
      -
    --0++x
      +
      y
    A#######B
    #       #
    #   X   #
    #       #
    C#######D
    
    center_pont(x,y) = X
    area = CD * DB
    """
    x = center_point[0]
    y = center_point[1]
    a = int(math.sqrt(area) / 2)

    A = (x-a,y-a) 
    B = (x+a,y-a)
    C = (x-a,y+a)
    D = (x+a,y+a)
    
    line_1 = cv2.line(image,A,D,(0,60,0),2)
    line_2 = cv2.line(image,B,C,(0,60,0),2)


def gradient(path,gradient_magnitude):
    
    im = Image.open(path)
    if im.mode != 'RGBA':
        im = im.convert('RGBA')

    width, height = im.size
    gradient = Image.new('L', (width, 1), color=0xFF)
    
    for x in range(width):
        gradient.putpixel((x, 0), int(255 * (1 - gradient_magnitude * float(x) / width)))

    alpha = gradient.resize(im.size)
    black_im = Image.new('RGBA', (width, height), color=0x000000)
    black_im.putalpha(alpha)
    gradient_im = Image.alpha_composite(im, black_im)

    return gradient_im