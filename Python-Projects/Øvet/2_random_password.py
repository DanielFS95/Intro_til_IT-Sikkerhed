import random

def generate_random_password():
    characters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
    numbers = "0123456789"
    special_characters = "!@#$%^&*()"

    password_length = random.randint(8, 16)
    password = ''.join(random.choice(characters) for _ in range(password_length))
    return password


if __name__ == "__main__":
    print("Generated Password:", generate_random_password())