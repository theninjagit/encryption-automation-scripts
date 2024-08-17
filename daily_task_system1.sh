#!/bin/bash

# Variables
SYSTEM1_DIR=~/System1
SYSTEM2_IP="192.168.56.102" 
FILE_NAME="scheduled_file.txt"
SIGNATURE_FILE="scheduled_file.sig"
ENCRYPTED_FILE="encrypted_file_for_system2.enc"
PRIVATE_KEY="$SYSTEM1_DIR/private_key_system1.pem"
PUBLIC_KEY_RECIPIENT="$SYSTEM1_DIR/public_key_system2.pem"
RECEIVED_ENCRYPTED_FILE="$SYSTEM1_DIR/encrypted_file_for_system1.enc"
RECEIVED_DECRYPTED_FILE="$SYSTEM1_DIR/decrypted_file.txt"
RECEIVED_SIGNATURE_FILE="$SYSTEM1_DIR/scheduled_file.sig1"
PUBLIC_KEY_SENDER="$SYSTEM1_DIR/public_key_system2.pem"

echo "This is a scheduled file from System1." > "$SYSTEM1_DIR/$FILE_NAME"

openssl dgst -sha256 -sign "$PRIVATE_KEY" -out "$SYSTEM1_DIR/$SIGNATURE_FILE" "$SYSTEM1_DIR/$FILE_NAME"
openssl rsautl -encrypt -inkey "$PUBLIC_KEY_RECIPIENT" -pubin -in "$SYSTEM1_DIR/$FILE_NAME" -out "$SYSTEM1_DIR/$ENCRYPTED_FILE"
scp "$SYSTEM1_DIR/$ENCRYPTED_FILE" "$SYSTEM1_DIR/$SIGNATURE_FILE" binima@192.168.56.102:~/System2/
openssl rsautl -decrypt -inkey "$PRIVATE_KEY" -in "$RECEIVED_ENCRYPTED_FILE" -out "$RECEIVED_DECRYPTED_FILE"
openssl dgst -sha256 -verify "$PUBLIC_KEY_SENDER" -signature "$RECEIVED_SIGNATURE_FILE" "$RECEIVED_DECRYPTED_FILE"

echo "System1: Process completed successfully."

