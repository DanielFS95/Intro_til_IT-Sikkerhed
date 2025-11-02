import os

#Find specifikke filer: Brug os- eller pathlib-modulet til at gennemgå alle filer i /etc og printe navnene på dem, der ender med .conf.
def list_files_in_directory(directory):
    files = os.listdir(directory)
    for file in files:
        if file.endswith('.conf'):
            print(file)

#Tjek om en fil eksisterer: Brug os.path.exists() eller pathlib.Path.exists() til at tjekke for en fil og printe en bekræftende eller afkræftende besked.
def file_exist():
    path = 'C:/Users'
    if os.path.exists(path):
        print(f"The file {path} exists.")
    else:
        print(f"The file {path} does not exist.")

#Omdøb filer: Skriv et script, der omdøber alle .txt-filer i en mappe til .md-filer ved hjælp af os.listdir() og os.rename().
def rename_file():
    files = os.listdir('C:/Users/Daniel/Desktop/Testfolder')
    for file in files:
        if file.endswith(".txt"):
            os.rename(f'C:/Users/Daniel/Desktop/Testfolder/{file}', f'C:/Users/Daniel/Desktop/Testfolder/{file}.md')
            print("File renamed successfully.")
            return


if __name__ == "__main__":
    while True:
        print("1. List .conf files in directory")
        print("2. Check if a specific file exists")
        print("3. Rename a file")
        print("4. Exit")
        choice = input("What do you want to do?: ")

        if choice == "1":
            list_files_in_directory('C:/Users/Daniel/Desktop/Testfolder')

        elif choice == "2":
            file_exist()

        elif choice == "3":
            rename_file()

        elif choice == "4":
            break

        else:
            print("Invalid choice.")