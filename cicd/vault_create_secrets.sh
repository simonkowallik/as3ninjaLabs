#!/usr/bin/env bash
# this script creates "test secrets"

VAULTDIR=/tmp/vault
mkdir -p $VAULTDIR

echo "AES 128 $(openssl rand -hex 16)" > $VAULTDIR/aes.key1
echo "AES 128 $(openssl rand -hex 16)" > $VAULTDIR/aes.key2

echo -e "[req]\ndistinguished_name=dn\n[dn]\n[ext]\n"\
"basicConstraints=critical,CA:FALSE\n"\
"keyUsage=critical,digitalSignature,keyEncipherment\n"\
"subjectAltName=DNS:example.com,DNS:www.example.com\n"\
"extendedKeyUsage=critical,serverAuth,clientAuth\n" \
> $VAULTDIR/cnf && \
openssl req -x509 -newkey rsa:1024 -nodes -sha1 \
  -days 10 -batch -config $VAULTDIR/cnf -extensions ext -subj \
  "/C=AQ/O=Penguin Corp./OU=Cuties/CN=www.example.com" \
  -keyout $VAULTDIR/key1k.pem -out $VAULTDIR/cert1k.pem \
  >/dev/null 2>&1
rm $VAULTDIR/cnf

echo -e "[req]\ndistinguished_name=dn\n[dn]\n[ext]\n"\
"basicConstraints=critical,CA:FALSE\n"\
"keyUsage=critical,digitalSignature,keyEncipherment\n"\
"subjectAltName=DNS:example.com,DNS:www.example.com\n"\
"extendedKeyUsage=critical,serverAuth,clientAuth\n" \
> $VAULTDIR/cnf && \
openssl req -x509 -newkey rsa:2048 -nodes -sha1 \
  -days 10 -batch -config $VAULTDIR/cnf -extensions ext -subj \
  "/C=AQ/O=Penguin Corp./OU=Cuties/CN=www.example.com" \
  -keyout $VAULTDIR/key2k.pem -out $VAULTDIR/cert2k.pem \
  >/dev/null 2>&1
rm $VAULTDIR/cnf
