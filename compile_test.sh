#!/usr/bin/env bash

gcc -z execstack -fno-stack-protector -s "./test_sc.c" -o "./test_sc"
