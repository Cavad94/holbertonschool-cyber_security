#!/bin/bash

if [ -z "$1" ]; then
    echo "Usage: $0 {xor}HASH"
    exit 1
fi

# {xor} hissəsini silirik
encoded_str="${1#\{xor\}}"

# Base64 ilə deşifrə edib hər baytı onluq (decimal) ədədə çeviririk, 
# sonra hər birini 95 ilə XOR edib simvola çevirərək çap edirik.
echo -n "$encoded_str" | base64 -d 2>/dev/null | od -v -An -t u1 | while read -r line; do
    for byte in $line; do
        # 95 (0x5f) ilə XOR əməliyyatı
        xor_result=$(( byte ^ 95 ))
        # Alınan ASCII kodunu simvola çevirib çap edirik
        printf "\\$(printf '%03o' "$xor_result")"
    done
done
echo ""
