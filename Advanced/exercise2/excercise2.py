import os

import imageio
import matplotlib.pyplot as plt
import rawpy

# This excercise concidered opening and doing some basic procecuress to a raw image. Python offers a third
# party called rawpy that provides some of the basic tools for doing that. 

def raw_to_jpg(path, bright=1.00, exp_shift=1.0, gamma=(2,6), save=False):
    """
    converts a raw image to jpg and saves it if user wants

    :param path: path for raw file
    :param bright: brightness
    :param exp_shift: exposure
    :param gamme: gamma value of the image
    :param save: save mode as boolean value
    """
    if os.path.exists(path):
        with rawpy.imread(path) as f:
            img = f.postprocess(rawpy.Params(bright=bright, use_auto_wb=True, exp_shift=exp_shift, gamma=gamma ))
            plt.imshow(img)
            plt.title('Preview')
            plt.show()
            
            if save:
                while True:
                    name = input('Name the file:\n')                
                    file_name = name + '{:s}.jpg'.format(name)
                    
                    target_path = './images/jpg/'
                        
                    if not os.path.exists(target_path + file_name):
                        imageio.imsave(target_path + file_name, img)
                        break
                    else:
                        print('File already exists.\n')
    else:
        print('File not found.')


def main():

    path = './images/dng/IMG_0083.dng'
    raw_to_jpg(path)


if __name__ == '__main__':
    main()
