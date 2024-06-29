#!/bin/bash

# chmod +x /tmp/create_ca_cert.sh && /bin/bash /tmp/create_ca_cert.sh

DONE_MSG="DONE"
CA_FILES_NAME="ca-homelab"

echo "--- INSTALL OPENSSL ---"
apt install -y openssl
echo $DONE_MSG

echo

echo "--- GENERATE ${CA_FILES_NAME^^}.KEY ---"
openssl genrsa -des3 -out $CA_FILES_NAME.key 2048
echo $DONE_MSG

echo

echo "--- GENERATE ${CA_FILES_NAME^^}.PEM ---"
openssl req -x509 -new -nodes -key $CA_FILES_NAME.key -sha256 -days 10000 -out $CA_FILES_NAME.pem -subj "/C=FR/ST=Ile-de-France/L=Paris/O=Homelab/CN=Homelab CA"
echo $DONE_MSG

echo

echo "--- GENERATE ${CA_FILES_NAME^^}.CRT ---"
openssl x509 -in $CA_FILES_NAME.pem -inform PEM -out $CA_FILES_NAME.crt
echo $DONE_MSG

echo
