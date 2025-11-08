#!/bin/bash

# Spørg brugeren om de første tre dele af subnet-adressen
read -p "Indtast de første tre dele af dit subnet (f.eks. 192.168.1): " BASE_IP

# Tjek om input er tomt
if [ -z "$BASE_IP" ]; then
    echo "Fejl: Intet input. Afslutter."
    exit 1
fi

echo ""
echo "Scanner $BASE_IP.1 til $BASE_IP.254..."
echo "-----------------------------------"

# Loop gennem alle værtsadresser fra 1 til 254
for i in $(seq 1 254); do
    IP_ADDRESS="$BASE_IP.$i"
    
    # Start hver ping-kommando i en separat baggrundsproces (med &)
    # Dette gør, at vi kan scanne alle 254 adresser samtidigt.
    (
        # -c 1: Send kun én ping-pakke
        # -W 1: Vent maks 1 sekund på svar
        # &> /dev/null: Skjul al output (både stdout og stderr)
        ping -c 1 -W 1 "$IP_ADDRESS" &> /dev/null
        
        # Tjek exit-koden fra ping. 0 = succes (værten er online)
        if [ $? -eq 0 ]; then
            echo "$IP_ADDRESS er online"
        fi
    ) &
done

# Vent på, at alle baggrundsprocesserne (ping-kommandoerne) er færdige
wait

echo "-----------------------------------"
echo "Scan færdig."