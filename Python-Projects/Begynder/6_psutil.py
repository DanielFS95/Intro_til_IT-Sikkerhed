import psutil

def get_running_process():
    """Get a list of all running processes."""
    process_list = []
    for proc in psutil.process_iter(['pid', 'name', 'username']):
        process_info = proc.info
        process_list.append(process_info)

    for process in process_list:
        print("______________")
        for key, value in process.items():
            print(f"{key}: {value}")
        #print(process)


if __name__ == "__main__":
    get_running_process()
