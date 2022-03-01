#!/bin/bash

mkdir builds

for file_path in roles/*.txt; do
    file_name=$(basename -- "$file_path")
    role_name=${file_name%.*}

    mkdir builds/presets

    while IFS= read -r preset_path; do
        cp "$preset_path" builds/presets/
    done < "$file_path"

    cd builds

    zip -r "$role_name.zip" presets/

    rm -r presets

    cd ..
done