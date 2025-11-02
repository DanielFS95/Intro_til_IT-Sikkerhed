import socket



def check_open_port(host, ports):
    port_result = []
    for n in ports:
        with socket.socket(socket.AF_INET, socket.SOCK_STREAM) as sock:
            sock.settimeout(1)  # Set a timeout for the connection attempt
            result = sock.connect_ex((host, n))
            if result == 0:
                port_result.append(n)
            else:
                port_result.append(False)
    return port_result
    

if __name__ == "__main__":
    host = input("Which host do you want to scan? (IP or domain): ")
    ports = input ("Which ports do you want to scan? (separate with commas): ")
    ports = [int(port) for port in ports.split(",")]

    for port in check_open_port(host, ports):
        if port is False:
            print(f"Port {port} on {host} is closed or unreachable.")
        else:
            print(f"Port {port} on {host} is open.")
