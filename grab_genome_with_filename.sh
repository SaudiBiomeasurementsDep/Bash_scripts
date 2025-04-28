#!/bin/bash

for dir in */; do
    base_name="${dir%/}"  # Strip trailing slash to get base name

    echo "Processing folder: $base_name"

    gcf_dir=$(find "$dir"/ncbi_dataset/data -maxdepth 1 -type d -name "GCF*" | head -n 1)

    if [[ -n "$gcf_dir" ]]; then
        echo "Found GCF directory: $gcf_dir"

        file_to_grab=$(find "$gcf_dir" -maxdepth 1 -type f | head -n 1)

        if [[ -n "$file_to_grab" ]]; then
            echo "Found file $file_to_grab"

            extension="${file_to_grab##*.}"
            new_filename="${base_name}.${extension}"

            cp "$file_to_grab" "$new_filename"

            echo "Copied and renamed to: ${new_filename}"
        else
            echo "No file found in $gcf_dir"
        fi
    else
        echo "No GCF directory in $dir"
    fi
done
