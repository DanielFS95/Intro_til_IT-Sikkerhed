#!/bin/bash

echo "--- Viser de 10 sidste mislykkede loginforsøg ---"
echo ""

# 'grep' søger efter mønsteret "Failed password" i logfilen
# 'tail -n 10' tager kun de sidste 10 linjer af det, grep fandt

grep "Failed password" /var/log/auth.log | tail -n 10