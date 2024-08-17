#!/bin/bash

SYSTEM2_DIR=~/System2
SYSTEM1_IP="192.168.56.105"
FILE_NAME="scheduled_file.txt"
SIGNATURE_FILE="scheduled_file.sig"
ENCRYPTED_FILE="encrypted_file_for_system1.enc"
PRIVATE_KEY="$SYSTEM2_DIR/private_key_system2.pem"
PUBLIC_KEY_RECIPIENT="$SYSTEM2_DIR/public_key_system1.pem"
RECIEVED_ENCRYPTED_FILE="$SYSTEM2_DIR/encrypted_file_for_system2.enc"
RECIEVED_DECRYPTED_FILE="$SYSTEM2_DIR/decrypted_file.txt"
RECEIVED_SIGNATURE_FILE="$SYSTEM2_DIR/scheduled_file.sig"
PUBLIC_KEY_SENDER="$SYSTEM2_DIR/public_key_system1.pem"

echo "this from system2" > "$SYSTEM2_DIR/$FILE_NAME"
openssl dgst -sha256 -sign "$PRIVATE_KEY" -out "$SYSTEM2_DIR/SIGNATURE_FILE"
openssl rsautl -encrypt -inkey "$PUBLIC_KEY_RECIPIENT" -pubin -in "$SYSTEM2_DIR/$FILE_NAME" -out "$SYSTEM2_DIR/$ENCR>
scp "$SYSTEM2_DIR/$ENCRYPTED_FILE" "$SYSTEM2_DIR/$SIGNATURE_FILE" binima@192.168.56.105:~/System1/
openssl rsautl -decrypt -inkey "$PRIVATE_KEY" -in "$RECEIVED_ENCRYPTED_FILE" -out "$RECEIVED_DECRYPTED_FILE"
openssl dgst -sha256 -verify "$PUBLIC_KEY_SENDER" -signature "$RECEIVED_SIGNATURE_FILE" "$RECEIVED_DECRYPTED_FILE"

echo "System2: Process completed successfully."


