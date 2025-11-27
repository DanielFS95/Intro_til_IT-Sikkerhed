#!/usr/bin/python
import socket
import sys
import concurrent.futures
from datetime import datetime

def scan_port(ip, port):
    """
    Tjekker en port. Returnerer True hvis åben, False hvis lukket.
    """
    try:
        with socket.socket(socket.AF_INET, socket.SOCK_STREAM) as sock:
            sock.settimeout(1) 
            result = sock.connect_ex((ip, port))
            if result == 0:
                return True
    except:
        pass
    return False

def run_scanner(ip, ports):
    print(f"-" * 50)
    print(f"Scanner mål: {ip}")
    print(f"Startet: {datetime.now()}")
    print(f"-" * 50)

    # Vi gemmer resultaterne i en liste i stedet for at printe med det samme
    scan_results = []
    
    with concurrent.futures.ThreadPoolExecutor(max_workers=50) as executor:
        future_to_port = {executor.submit(scan_port, ip, port): port for port in ports}
        
        for future in concurrent.futures.as_completed(future_to_port):
            port = future_to_port[future]
            try:
                is_open = future.result()
                # Gem resultatet som en tuple: (port_nummer, status)
                scan_results.append((port, is_open))
            except Exception as exc:
                print(f"Port {port} fejl: {exc}")

    # Sorter listen baseret på portnummer (index 0 i tuplen)
    scan_results.sort(key=lambda x: x[0])

    # Print den sorterede liste
    for port, is_open in scan_results:
        status = "ÅBEN" if is_open else "LUKKET"
        # Bruger farvekoder (hvis din terminal understøtter det) eller bare tekst
        print(f"Port {port}: \t {status}")

    print(f"-" * 50)
    print("Scanning færdig.")

if __name__ == "__main__":
    target_ip = 'localhost' 
    ports_to_scan = [21, 22, 80, 443, 3306, 8080]
    
    try:
        target_ip = socket.gethostbyname(target_ip)
        run_scanner(target_ip, ports_to_scan)
    except socket.gaierror:
        print("Kunne ikke løse hostname.")
        sys.exit()
    except KeyboardInterrupt:
        print("\nAfslutter scanning...")
        sys.exit()