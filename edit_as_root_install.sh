#!/bin/bash

# Check if a hostname/IP and a user are provided
if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <remote_host e.g gitlab-ec2>"
    exit 1
fi

REMOTE_HOST="$1"
# Step 1: Securely copy the edit_as_root.sh script to the remote machine's home directory
scp edit_as_root.sh "${REMOTE_HOST}:~/"
# SSH command to create and install edit_as_root.sh on the remote machine
ssh "${REMOTE_HOST}" bash -s << 'EOF'

# Make the script executable
chmod +x ~/edit_as_root.sh

# Move the script to a location in the user's PATH (e.g., /usr/local/bin)
sudo mv ~/edit_as_root.sh /usr/local/bin/

# Add an alias to the user's shell configuration file (.bashrc or .zshrc)
# only if it doesn't exist already
if ! grep -q "alias edit_as_root=" ~/.bashrc; then
    echo 'alias edit_as_root="/usr/local/bin/edit_as_root.sh"' >> ~/.bashrc
fi

# Reload the shell configuration (optional, for the current session)
source ~/.bashrc || true

EOF

echo "edit_as_root has been installed on ${REMOTE_HOST}."