#!/bin/bash
set -e

process_package() {
    local target=$1
    pushd "$target"
    echo "Processing target: $target"
    makepkg -cfsi --noconfirm
    popd
}

while IFS= read -r target; do
    if [[ -d "$target" ]]; then
        process_package "$target"
    else
        echo "Directory $target does not exist"
    fi
done < pkgs

mkdir -pv outputs

find . -type f -name "*.pkg.tar.zst" -exec bash -c '
    for file; do
        dest="outputs/$(basename "$file")"
        if [[ ! -f "$dest" ]]; then
            mv "$file" outputs/
        else
            echo "File $dest already exists, skipping"
        fi
    done
' bash {} +
