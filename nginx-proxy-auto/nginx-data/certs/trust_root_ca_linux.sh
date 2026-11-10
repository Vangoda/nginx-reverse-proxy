#!/bin/bash
set -euo pipefail

if [ "$#" -ne 1 ]; then
  echo "Usage: $0 <path_to_rootCA.pem>"
  exit 1
fi

sudo install -m 0644 "$1" \
  /usr/local/share/ca-certificates/vangoda-rootCA.crt

sudo update-ca-certificates

echo "Root CA certificate installed in the system trust store."
