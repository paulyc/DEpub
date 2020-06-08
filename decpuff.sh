#!/bin/bash

# decpuff <keyfile> <encrypteddeflatedfile>
# writes decryptedpuffedfile to stdout

if [[ "$#" -ne 2 ]]; then
	echo "Usage: $0 <binary keyfile> <encrypted deflated file>" 1>&2
	echo "Writes decrypted inflated file to stdout" 1>&2
	exit 1
fi

key=$(xxd -ps -c 999 $1)

# unsure if this is equivalent to iv=0 and decrypting
# the whole file but it works and i aint fixing it
dd if=$2 of=iv bs=1 count=16
iv=$(xxd -ps -c 999 iv)

dd if=$2 of=ciphertext.flate bs=1 skip=16
openssl aes-128-cbc -d -in ciphertext.flate -K $key -iv $iv -out plaintext.flate

cat plaintext.flate | puff/puff -w
