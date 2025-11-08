#!/bin/bash

TARGET_FILE="/etc/passwd"
LOG_FILE="passwd_changes.log"
INTERVAL=10

TEMP_FILE=$(mktemp)
trap 'rm -f "$TEMP_FILE"' EXIT
cp "$TARGET_FILE" "$TEMP_FILE"

echo "Overvåger $TARGET_FILE..."
echo "Logfil: $LOG_FILE"
echo "Tryk Ctrl+C for at stoppe."

while true
do
    DIFFERENCES=$(diff "$TARGET_FILE" "$TEMP_FILE")

    if [ -n "$DIFFERENCES" ]; then
        TIMESTAMP=$(date +"%Y-%m-%d %H:%M:%S")
        
        echo "[$TIMESTAMP] Ændring fundet i $TARGET_FILE!"
        
        echo "--- ÆNDRING FUNDET: $TIMESTAMP ---" >> "$LOG_FILE"
        echo "$DIFFERENCES" >> "$LOG_FILE"
        echo "-------------------------------------------" >> "$LOG_FILE"
        
        cp "$TARGET_FILE" "$TEMP_FILE"
    fi
    
    sleep $INTERVAL
done