#!/bin/bash

if [ -z "$1" ]; then
    echo "Usage: $0 {xor}HASH"
    exit 1
fi

# {xor} hissəsini silirik
encoded_str="${1#\{xor\}}"

# Base64-dən çıxarıb hər baytı 0x5f ilə XOR edirik
decoded_str=$(echo "$encoded_str" | base64 -d 2>/dev/null)

# Hər bir simvolu oxuyub XOR edirik
for (( i=0; i<${#decoded_str}; i++ )); do
    char="${decoded_str:$i:1}"
    # Simvolun ASCII dəyərini alırıq
    printf -v ascii '%d' "'$char"
    # 95 (0x5f) ilə XOR edirik
    xor_result=$(( ascii ^ 95 ))
    # Yenidən simvola çevirib çap edirik
    printf "\\$(printf '%03o' "$xor_result")"
done
echo ""
