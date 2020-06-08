#!/bin/bash -x

if [[ "$#" -ne 3 ]]; then
	echo "Usage: $0 <activation.xml> <encrypted epub> <decrypted epub>" 2>&1
	exit 1
fi

mv $2 tmp.zip
rm -rf enc
mkdir enc
cd enc
unzip ../tmp.zip
cd ..
rm -rf dec
mkdir dec
cp -R enc/META-INF dec/
mv -f dec/META-INF/rights.xml .
mv -f dec/META-INF/encryption.xml .
./decrypt_user_key.sh $1 rights.xml > key
# really need to get the list of encrypted files and keys from encryption.xml
# TODO
#
files=$(find enc -type f)
for file in "$files"; do
	mkdir -p dec/$(dirname $file)
	./decpuff.sh key "$file" > dec/$file
done
cd dec
zip -r ../dec.zip *
mv ../dec.zip $3

