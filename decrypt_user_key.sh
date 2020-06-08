#!/bin/bash

if [[ "$#" -ne 2 ]]; then
	echo "Usage: $0 <activation.xml> <rights.xml>" 1>&2
	echo "Writes decrypted AES user epub decryption key to stdout" 1>&2
	exit 1
fi

./extract_license_key.sh $1 > license.key.der

grep 'encryptedKey keyInfo="user"' $2 | sed 's/^.*<encryptedKey keyInfo="user">\(.*\)<\/encryptedKey>.*$/\1/' | base64 -d > key.enc

openssl rsautl -decrypt -in key.enc -inkey license.key.der -keyform DER

