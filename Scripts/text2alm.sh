#!/bin/bash
echo "Text2ALM..."
python CommandCenter.py text2alm --input $1
echo "${1##*/}"
