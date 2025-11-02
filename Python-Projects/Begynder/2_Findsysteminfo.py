import socket

def print_system_info():
    hostname = socket.gethostname()
    print(f"Hostname: {hostname}")

    ip_address = socket.gethostbyname(hostname)
    print(f"IP Address: {ip_address}")


if __name__ == "__main__":
    print_system_info()