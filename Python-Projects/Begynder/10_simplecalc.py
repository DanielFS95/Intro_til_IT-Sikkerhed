
def calc():
    number1 = float(input("Enter first number: "))
    number2 = float(input("Enter second number: "))
    operation = input("Enter operation (+, -, *, /): ")
    if operation == "+":
        print(f"{number1} + {number2} = {number1 + number2}")
    elif operation == "-":
        print(f"{number1} - {number2} = {number1 - number2}")
    elif operation == "*":
        print(f"{number1} * {number2} = {number1 * number2}")
    elif operation == "/":
        if number2 != 0:
            print(f"{number1} / {number2} = {number1 / number2}")
        else:
            print("Error: Division by zero is not allowed.")
    else:
        print("Invalid operation.")

if __name__ == "__main__":
    calc()