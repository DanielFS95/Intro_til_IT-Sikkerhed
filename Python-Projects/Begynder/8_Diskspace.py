import shutil

def get_disk_space():
    total, used, free = shutil.disk_usage("/")
    print("Disk Space Information:")
    print(f"Total: {total // (2**30)} GiB")
    print(f"Used: {used // (2**30)} GiB")
    print(f"Free: {free // (2**30)} GiB")
    if free / total < 0.2:
        print("Warning: Less than 20% disk space remaining!")


if __name__ == "__main__":
    get_disk_space()