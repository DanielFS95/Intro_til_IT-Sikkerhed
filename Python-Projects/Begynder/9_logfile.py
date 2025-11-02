def open_logfile(filename):
        logfile = open(filename, 'r')
        for line in logfile:
            if "Failed" in line:
                print(line)


if __name__ == "__main__":
    open_logfile('C:/Users/Daniel/Desktop/Testfolder/logfile.log')