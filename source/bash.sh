#!/bin/bash

for file in *-en.txt; do
mv "$file" "${file%-en.txt}.rst"
done
