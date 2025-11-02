import os
import hashlib

def file_change_detecter():
    directory = 'C:/Users/Daniel/Desktop/Testfolder'
    files = os.listdir(directory)
    for file in files:
        if file.endswith(".txt"):
            print(file)
            path = os.path.join(directory, file)
            hash_md5 = hashlib.md5(open(path, "rb").read()).hexdigest()
            print(hash_md5)
            

if __name__ == "__main__":
    file_change_detecter()