#!/bin/bash

shopt -s dotglob

echo "Setting up dotfiles"

skip_files=("setup.sh" "tiny_vimrc")

for file in "$HOME/dotfiles"/*; do
  filename=$(basename "$file")

  if [[ " ${skip_files[@]} " =~ " $filename " ]]; then
    echo "Skipping file: $filename"
    continue
  fi

  home_file="$HOME/$filename"
  backup_file="backup_$(date +"%Y%m%d%H%M%S")_$filename"

  echo "Checking $filename"
  if [ -f "$home_file" ]; then
    echo "Already existing $home_file. Moving to $HOME/$backup_file"
    mv "$home_file" "$HOME/$backup_file"
  fi
  ln -s "$file" "$home_file"
done
