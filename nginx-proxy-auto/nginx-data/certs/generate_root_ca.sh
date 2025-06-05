#!/bin/bash

# Generate the private key for the CA
openssl genrsa -out rootCA.key 2048

# Create the root certificate
openssl req -x509 -new -nodes -key rootCA.key -sha256 -days 1024 -out rootCA.pem
