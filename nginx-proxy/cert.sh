#!/bin/sh

if [ "$#" -ne 1 ]
then
    echo "Usage: Must supply a domain"
    exit 1
fi

DOMAIN=$1
CERT_DIR="nginx-data/certs/"
ROOT_CA="VanPredatorCA"

cd ~/certs

openssl genrsa -out "$CERT_DIR$DOMAIN.key" 2048
openssl req -new -key "$CERT_DIR$DOMAIN.key" -out "$CERT_DIR$DOMAIN.csr"

cat > "$CERT_DIR$DOMAIN.ext" << EOF
authorityKeyIdentifier=keyid,issuer
basicConstraints=CA:FALSE
keyUsage = digitalSignature, nonRepudiation, keyEncipherment, dataEncipherment
subjectAltName = @alt_names
[alt_names]
DNS.1 = $DOMAIN
EOF

openssl x509 -req -in "$CERT_DIR$DOMAIN.csr" -CA "$CERT_DIR$ROOT_CA.pem" -CAkey "$CERT_DIR$ROOT_CA.key" -CAcreateserial -out "$CERT_DIR$DOMAIN.crt" -days 365 -sha256 -extfile "$CERT_DIR$DOMAIN.ext"