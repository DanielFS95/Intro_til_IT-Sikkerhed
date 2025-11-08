#!/bin/bash

echo "--- Filer i /etc, der slutter på .conf ---"
echo ""

# -type f: Søg kun efter almindelige filer (ikke mapper)
# -name "*.conf": Find navne, der matcher mønsteret .conf
# 2>/dev/null: Skjul "Permission denied" fejl fra mapper,
#              din bruger ikke har adgang til at læse.
find /etc -type f -name "*.conf" 2>/dev/null

echo ""
echo "----------------------------------------"