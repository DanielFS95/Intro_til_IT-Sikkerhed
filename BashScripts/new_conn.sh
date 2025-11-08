#!/bin/bash

# ----- Konfiguration -----
LOG_FILE="network_log.txt"
INTERVAL=5 # Sekunder mellem hvert tjek

# Kommandoen til at hente forbindelser.
# ss -tunap: Viser TCP (t), UDP (u), numerisk (n), alle (a), processer (p)
# grep -v "LISTEN": Fjerner statiske "LISTEN" porte, da vi kun vil se aktive/nye.
# sort: Nødvendigt for at 'comm' kommandoen kan sammenligne filerne korrekt.
GET_CONNS_CMD="ss -tunap | grep -v 'LISTEN' | sort"
# ---------------------------

# Opret to midlertidige filer til at gemme "før" og "nu" snapshots
OLD_CONNS=$(mktemp)
NEW_CONNS=$(mktemp)

# Sørg for, at de midlertidige filer slettes, når scriptet stoppes (Ctrl+C)
trap 'rm -f "$OLD_CONNS" "$NEW_CONNS"' EXIT

# Tag det første snapshot som vores udgangspunkt
eval "$GET_CONNS_CMD" > "$OLD_CONNS"

echo "Overvåger for nye netværksforbindelser (Ctrl+C for at stoppe)..."
echo "Logfil: $LOG_FILE"
echo "---------------------------------------------------------------"

# Start en uendelig løkke
while true
do
    # Tag et nyt snapshot af de nuværende forbindelser
    eval "$GET_CONNS_CMD" > "$NEW_CONNS"
    
    # Sammenlign den nye fil med den gamle.
    # 'comm -13' viser kun linjer, der er UNIKKE for den NYE fil.
    DIFF=$(comm -13 "$OLD_CONNS" "$NEW_CONNS")
    
    # Tjek om 'comm' fandt nogen forskelle (nye forbindelser)
    if [ -n "$DIFF" ]; then
        TIMESTAMP=$(date +"%Y-%m-%d %H:%M:%S")
        
        # Vis en besked i terminalen om, at noget er fundet
        echo "[$TIMESTAMP] Nye forbindelser opdaget:"
        echo "$DIFF"
        echo ""
        
        # Log de nye forbindelser til logfilen
        echo "--- NYE FORBINDELSER: $TIMESTAMP ---" >> "$LOG_FILE"
        echo "$DIFF" >> "$LOG_FILE"
        echo "----------------------------------------" >> "$LOG_FILE"
    fi
    
    # VIGTIGT: Opdater den "gamle" fil til at være den "nye",
    # så vi er klar til næste sammenligning.
    cat "$NEW_CONNS" > "$OLD_CONNS"
    
    # Vent i X antal sekunder før næste tjek
    sleep $INTERVAL
done