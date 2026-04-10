#!/bin/bash

echo "Decompressing BadApple..."

gunzip -c /usb/payloads/badapple.gz > /tmp/badapple.sh 2>/dev/null

clear
. /tmp/badapple.sh
clear