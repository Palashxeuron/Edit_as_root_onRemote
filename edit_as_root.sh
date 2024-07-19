#!/bin/bash

if [ "$#" -ne 1 ]; then
    echo "Usage: $0 /path/to/file"
    exit 1
fi

FILE_PATH="$1"

# Change ownership to the current user
sudo chown $(whoami) ${FILE_PATH}

# Open the file with VSCode and wait
code --wait ${FILE_PATH}

# Change the ownership back to root
sudo chown root:root ${FILE_PATH}
EOT

# Make the script executable
chmod +x edit_as_root.sh

# Move the script to a location in the user's PATH (e.g., /usr/local/bin)
sudo mv edit_as_root.sh /usr/local/bin/

# Add an alias to the user's shell configuration file (.bashrc or .zshrc)
# only if it doesn't exist already
if ! grep -q "alias edit_as_root=" ~/.bashrc; then
    echo 'alias edit_as_root="edit_as_root.sh"' >> ~/.bashrc
fi

# Reload the shell configuration (optional, for the current session)
source ~/.bashrc || true