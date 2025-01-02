#!/bin/bash
#
# 2024-04-10 Rajesh Parab
# 2024-04-24 Updated
# 2024-05-02 FRC
#
# $0 is the script name i.e. bash, $1 first ARG, $2 is second..
#
# Using chmod u+x scriptname make the script executable.
#
###############################################################################
#
# (1) Generate SSH Key Pair on Dvlpr-PC or Ansible-Control-Node or Server
#
#     ssh-rajesh@kdedsk-ip65-ed25519
#     ssh-rajesh@kdedsk-ip65-ed25519.pub
#
#     ssh-sairam@lxdedsk-ip71-ed25519
#     ssh-sairam@lxdedsk-ip71-ed25519.pub
#
# Usage at bottom of EOF
#
###############################################################################

host_name=$(hostname)
host_user=$USER
ssh_keyfile_path="$HOME/.ssh"
ssh_keytype="ed25519"  # VALID options are RSA, DSA, ECDSA, and ed25519
cStartTag="ssh-"
cEndTag="-ed25519"
#---New-Key-Format---------------------
ssh_keyfile_name="$ssh_keyfile_path/$cStartTag$host_user@$host_name$cEndTag"
#                 /home/rajesh/.ssh/ssh-rajesh@lxdedsk-ip65-ed25519
#--------------------------------------
ssh_keyfile_private="$ssh_keyfile_name"
ssh_keyfile_public="$ssh_keyfile_name.pub"

echo '...'
echo 'Bash Script Start - Generate SSH Keyfile Pair...'
echo '...'

#---Check if the ssh key file already exists-----------------------
if [ -f "$ssh_keyfile_private" ] && [ -f "$ssh_keyfile_public" ]; then
  echo "Error: SSH Private Keyfile already exists at ==> $ssh_keyfile_private"
  echo "Error: SSH Public Keyfile already exists at ===> $ssh_keyfile_public"
  echo '...'
  echo "no need to Generate SSH Key Pair again...you can copy these keypairs"
  echo 'if you want then delete the above keyfile pairs'
  echo 'and then run this program again'
  echo '...'
else
  # Generate the SSH key pair without passphrase and save it to key_file
  # -f "$output_file": Specifies the output file path for the private key.
  # -q: Quiet mode. Suppresses any non-error messages during key generation.
  # -N "": Specifies an empty passphrase for the private key, effectively disabling passphrase
  echo 'Start Generating New SSH Key Pair...'

  ssh-keygen -t "$ssh_keytype" -C "$host_name" -f "$ssh_keyfile_private" -q -N ""

  echo "..."
  echo "Successfully Generated SSH Private Key ==> $ssh_keyfile_private"
  echo "Successfully Generated SSH Public Key ===> $ssh_keyfile_public"
  echo '...'
fi
echo "NOTE: recommended permission for public key file should be 'chmod 644'"
echo "NOTE: recommended permission for private key file should be 'chmod 600' (have more restrictive permissions)"
echo '...'
echo 'Bash Script End...'
echo '...'
# EOF #

##############################################################################
#
# [rajesh@KdeDsk-ip65: ~]
#
# $ sshgkp <== shortcut in .bash_aliase
#
# $ . ssh-gen-keyfile-pair.sh
#
# == Use Case -1 ============================================================
#
# [rajesh@KdeDsk-ip65: ~]
# $ sshgkp
# ...
# Bash Script Start - Generate SSH Keyfile Pair...
# ...
# Generated SSH Keyfile Name and path ==> /home/rajesh/.ssh/ssh-ed25519-rajesh@KdeDsk-ip65
# ...
# Start Generating New SSH Key Pair...
# ...
# Successfully Generated SSH Private Key ==> /home/rajesh/.ssh/ssh-ed25519-rajesh@KdeDsk-ip65
# Successfully Generated SSH Public Key ===> /home/rajesh/.ssh/ssh-ed25519-rajesh@KdeDsk-ip65.pub
# ...
# NOTE: recommended permission for public key file should be 'chmod 644'
# NOTE: recommended permission for private key file should be 'chmod 600' (have more restrictive permissions)
# ...
# Bash Script End...
# ...
#
# == Use Case -2 ============================================================
#
# [rajesh@KdeDsk-ip65: ~]
# $ sshgkp
# ...
# Bash Script Start - Generate SSH Keyfile Pair...
# ...
# Generated SSH Keyfile Name and path ==> /home/rajesh/.ssh/ssh-ed25519-rajesh@KdeDsk-ip65
# ...
# Error: SSH Private Keyfile already exists at ==> /home/rajesh/.ssh/ssh-ed25519-rajesh@KdeDsk-ip65
# Error: SSH Public Keyfile already exists at ===> /home/rajesh/.ssh/ssh-ed25519-rajesh@KdeDsk-ip65.pub
# ...
# no need to Generate SSH Key Pair again...you can copy these keypairs
# if you want then delete the above keyfile pairs
# and then run this program again
# ...
# NOTE: recommended permission for public key file should be 'chmod 644'
# NOTE: recommended permission for private key file should be 'chmod 600' (have more restrictive permissions)
# ...
# Bash Script End...
# ...
#
##############################################################################
