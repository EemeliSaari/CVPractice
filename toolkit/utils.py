def imread(path):
    """
    """
    with open(path, 'rb') as file:
        for i in file:
            print(i)


imread('./images/png/simple.png')