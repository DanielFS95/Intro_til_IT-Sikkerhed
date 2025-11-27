#!/usr/bin/python3
import socket

def start_client(server_ip, server_port):
    try:
        with socket.socket(socket.AF_INET, socket.SOCK_STREAM) as sock:
            print(f"[*] Forbinder til {server_ip}:{server_port}...")
            sock.connect((server_ip, server_port))
            print("[+] Forbindelse oprettet! Ventet på besked fra serveren...")

            # Send en start-besked
            sock.sendall(b"Klient er klar. Skriv noget i ncat!\n")

            # Løkke der bliver ved med at lytte
            while True:
                # Scriptet pauser her indtil ncat sender data
                data = sock.recv(1024)
                
                # Hvis data er tom, betyder det at serveren lukkede forbindelsen
                if not data:
                    print("[*] Serveren lukkede forbindelsen.")
                    break
                
                print(f"[Input fra server]: {data.decode('utf-8').strip()}")

    except ConnectionRefusedError:
        print("[!] Kunne ikke forbinde. Husk at starte ncat først!")
    except KeyboardInterrupt:
        print("\n[*] Lukker klienten.")
    except Exception as e:
        print(f"[!] Fejl: {e}")

if __name__ == "__main__":
    start_client("127.0.0.1", 45679)
