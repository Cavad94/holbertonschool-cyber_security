#!/bin/bash
if [ -z "$1" ]; then
    echo "Usage: $0 {xor}HASH"
    exit 1
fi
encoded_str="${1#\{xor\}}"
echo "$encoded_str" | base64 -d | awk '
BEGIN { xor_key = 95 }
{
    split($0, chars, "")
    for (i = 1; i <= length($0); i++) {
        printf "%c", xor(ord(chars[i]), xor_key)
    }
    printf "\n"
}
function ord(c) { return chMap[c] }
BEGIN {
    for (i = 0; i < 256; i++) chMap[sprintf("%c", i)] = i
}'
