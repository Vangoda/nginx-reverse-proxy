#!/bin/sh

if [ "$#" -ne 1 ]
then
    echo "Nedostaje domena!"
    exit 1
fi

DOMAIN=$1
ROOT_CA="rootCA"

openssl genrsa -out "$DOMAIN.key" 2048
openssl req -new -key "$DOMAIN.key" -out "$DOMAIN.csr"

cat > "$DOMAIN.ext" << EOF
authorityKeyIdentifier=keyid,issuer
basicConstraints=CA:FALSE
keyUsage = digitalSignature, nonRepudiation, keyEncipherment, dataEncipherment
subjectAltName = @alt_names
[alt_names]
DNS.1 = $DOMAIN
EOF

openssl x509 -req -in "$DOMAIN.csr" -CA "$ROOT_CA.pem" -CAkey "$ROOT_CA.key" -CAcreateserial -out "$DOMAIN.crt" -days 365 -sha256 -extfile "$DOMAIN.ext"