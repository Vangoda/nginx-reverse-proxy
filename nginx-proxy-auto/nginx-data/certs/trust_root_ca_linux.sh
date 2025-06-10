#!/bin/bash

# Check if rootCA.pem is provided as an argument
if [ -z "$1" ]; then
  echo "Usage: $0 <path_to_rootCA.pem>"
  exit 1
fi

ROOT_CA_PEM=$1

# Copy the root CA certificate to the system's trusted store
sudo cp $ROOT_CA_PEM /usr/local/share/ca-certificates/rootCA.crt

# Update the system's trusted certificates
sudo update-ca-certificates

echo "Root CA certificate has been trusted on this machine."
