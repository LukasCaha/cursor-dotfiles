#!/bin/bash
set -e # Exit immediately if a command fails

# Get the absolute path to the directory this script is in
SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &> /dev/null && pwd)

# Define the target Cursor config directory
# On Linux, this is the standard path
CONFIG_DIR="$HOME/.config/Cursor/User"

# Create the target directory if it doesn't exist
mkdir -p "$CONFIG_DIR"

echo "Backing up any existing configs..."
# Move any existing files to .bak, suppress errors if they don't exist
mv "$CONFIG_DIR/settings.json" "$CONFIG_DIR/settings.json.bak" 2>/dev/null || true
mv "$CONFIG_DIR/keybindings.json" "$CONFIG_DIR/keybindings.json.bak" 2>/dev/null || true

echo "Creating symlinks..."
# Create 'force' (-f) symbolic links (-s) from this repo to the config dir
ln -sf "$SCRIPT_DIR/settings.json" "$CONFIG_DIR/settings.json"
ln -sf "$SCRIPT_DIR/keybindings.json" "$CONFIG_DIR/keybindings.json"

echo "Installing extensions from extensions.txt..."
# Read the extensions.txt file and install each extension
cat "$SCRIPT_DIR/extensions.txt" | xargs -L 1 cursor --install-extension

echo "✅ Setup complete! Please restart Cursor."
