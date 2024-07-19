# Edit_as_root_onRemote
installs an edit_as_root alias on the remote so that you can edit the root files on a vscode server instead of nano or vim

# Usage
- on your local machine , add the remote host to your ssh config (specify the pem key etc in the config)
- clone the repo
- cd into the repo and run
- ./edit_as_root_install.sh <hostname>
- verify the installation by viewing the ~/.bashrc on remote. EOF should look like this '''alias edit_as_root='/usr/local/bin/edit_as_root.sh'''
- run the utility as '''ubuntu@ip-123-45-67-980:~$ edit_as_root /etc/gitlab/gitlab.rb'''
