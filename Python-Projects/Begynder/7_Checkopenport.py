import socket



def check_open_port(host, port):
    with socket.socket(socket.AF_INET, socket.SOCK_STREAM) as sock:
        sock.settimeout(1)  # Set a timeout for the connection attempt
        result = sock.connect_ex((host, port))
        if result == 0:
            return True
        else:
            return False
    

if __name__ == "__main__":
    host = "google.com"
    port = 443

    if check_open_port(host, port) is True:
        print(f"Port {port} on {host} is open.")
    else:
        print(f"Port {port} on {host} is closed or unreachable.")
