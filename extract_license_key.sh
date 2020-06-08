#!/bin/bash

if [[ "$#" -ne 1 ]]; then
	echo "Usage: $0 <activation.xml>" 1>&2
	echo "Writes DER-encoded activation RSA private key to stdout" 1>&2
	exit 1
fi

grep 'adept:privateLicenseKey' $1 | sed 's/^.*<adept:privateLicenseKey>\(.*\)<\/adept:privateLicenseKey>.*$/\1/' | base64 -d

