#!/bin/bash
set -e

echo "Installing dotfiles using stow..."

# List all stow packages (each folder in repo)
PACKAGES=(zsh tmux git nvim gtk focus)

for package in "${PACKAGES[@]}"; do
  echo "Stowing $package..."
  stow --restow --target="$HOME" "$package"
done

echo "✅ Dotfiles setup complete with stow."
