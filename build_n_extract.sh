#!/usr/bin/env bash

nasm -f elf64 "$1.s" \
&& ld -o "$1" "$1.o" \
&& rm -f "$1.o" \
&& objdump -d "$1" \
|grep -E '^( +)([0-9a-f]+):' \
|awk -F'\t' '{print $2}' \
|tr -d '\n' \
|sed -e 's/ \+/ /g' -e 's/ $//g' -e 's/^/ /g' -e 's/ /\\x/g';
echo
