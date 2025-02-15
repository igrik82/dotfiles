#!/usr/bin/env bash

DOTFILES_LOCATION=$HOME/dotfiles
CONF_TO_STOW=$1

if [ -e "$CONF_TO_STOW" ]; then

  # Check if the config already stowed
  if [ ! -L "$CONF_TO_STOW" ]; then

    # Get the first character
    fist_char=$(basename "$CONF_TO_STOW" | cut -c1)

    # If the first character is a dot
    if [ "$fist_char" == "." ]; then
      # Remove the dot and create folder for stowed file
      STOWED_FOLDER=$(basename "$CONF_TO_STOW" | cut -c2-)
    else
      STOWED_FOLDER=$(basename "$CONF_TO_STOW")
    fi

    # Moving the config to the folder
    echo "Adding $CONF_TO_STOW to $DOTFILES_LOCATION/$STOWED_FOLDER"

    # Stow the config
    real_path_config=$(readlink -f "$CONF_TO_STOW")
    stow_dir="${real_path_config/#$HOME/$DOTFILES_LOCATION/$STOWED_FOLDER}"
    stow_dir_without_last_path=$(dirname "$stow_dir")
    echo "Create directory $STOWED_FOLDER"
    # echo "full $stow_dir"
    # echo "without last path $stow_dir_without_last_path"
    mkdir -p "$stow_dir_without_last_path"
    echo "Moving $real_path_config to $stow_dir"
    mv "$real_path_config" "$stow_dir_without_last_path"

    cd "$DOTFILES_LOCATION" || exit
    stow "$STOWED_FOLDER"

  else
    echo "$CONF_TO_STOW is already stowed!"
  fi

fi
