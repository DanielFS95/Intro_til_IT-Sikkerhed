#!/bin/bash

# Ask the user for the port number
read -p "Which port do you want to check?: " PORT

# Check if input is empty
if [ -z "$PORT" ]; then
    echo "Error: No port number provided. Exiting."
    exit 1
fi

echo "Checking status for port $PORT..."
echo ""

# -l = Show listening ports
# -n = Show numeric addresses/ports (much faster)
# -t = Show TCP
# -u = Show UDP
#
# grep -q: Searches "quietly". Stops and returns 'true'
#          as soon as it finds a match.
# :\b$PORT\b: Searches for the port number surrounded by "word boundaries"
#          (e.g., :22) to avoid matching '22' in port '122'.

if ss -lntu | grep -q ":\b$PORT\b"; then
    echo "Result: Port $PORT is OPEN (a service is listening)"
    echo ""
    # Show the specific lines for context
    ss -lntu | grep ":\b$PORT\b"
else
    echo "Result: Port $PORT is CLOSED (or no service is listening)"
fi