#!/bin/bash
set -e

sleep 3

RESPONSE=$(curl -s -o /dev/null -w "%{http_code}" http://localhost:8080)

if [ "$RESPONSE" == "200" ]; then
  echo "Health check passed! App is running."
else
  echo "Health check failed! HTTP status: $RESPONSE"
  exit 1
fi
