from datetime import datetime

def print_current_datetime():
    now = datetime.now().strftime("%Y-%m-%d %H:%M:%S")
    print(f"Current date and time: {now}")

if __name__ == "__main__":
    print_current_datetime()