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
# (2) Copy Public-Key from Dvlpr-PC to Remote-Host
#
# Usage at bottom of EOF
#
###############################################################################

source ~/rpa/installer/script/bash/ssh-keyfile/helpers.sh

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

input_ipaddress_last_2digit="$1"
remote_username="$2"

#---PARAMETER NOT PASSED THEN EXIT.------------------------------------
if [ -z "$input_ipaddress_last_2digit" ]; then #---double Quote only---
  echo '...'
  echo 'Error !!! Required Parameter (Remote IP-Address last 2 digit) ?'
  echo 'Optional Parameter Remote [ username ] default=admin'
  echo "sshcpk 75 [admin]"
  echo '...'
  return
  #exit 1
fi
if [ -z "$remote_username" ]; then
    remote_username="admin"
fi
#---Build Full IP-Address--------------------------------------------
networkmask="192.168.1"
remote_server_ip_address="$networkmask.$input_ipaddress_last_2digit"
echo '...'
echo 'Check if Remote host is reachable before attempting SSH Copy...'
if ! check_remote_host_reachable; then
  echo 'exiting bash script'
  echo '...'
  return
fi
# --------------------------------------------------------------------
if ! [ -f "$ssh_keyfile_public" ]; then
  echo '...'
  echo "Error: SSH Public keyfile Not found ==> $ssh_keyfile_public"
  echo 'Please use the (ssh-gen-keyfile-pair.sh) bash script to'
  echo 'Generate a NEW SSH Private Public Keyfile Pair'
  echo 'and then run this bash script'
  echo '...'
  return
fi
# -----------------------------------------------------------------
echo '...'
echo 'Bash Script Start - Copy SSH Public Kefile to remote host...'
echo '...'
echo "SSH Public keyfile to copy ==> $ssh_keyfile_public"
echo '...'
echo "Remote Host ==> $remote_username@$remote_server_ip_address"
echo '...'

# shows warning messages on console
ssh-copy-id -i "$ssh_keyfile_public" "$remote_username@$remote_server_ip_address"

# suppress warning on console
# ssh-copy-id -i "$ssh_keyfile_public" "$remote_username@$remote_server_ip_address" 2>/dev/null

echo "Job Done exit..."

# EOP
#-----------------------------------------------------------------------------


# EOF #

##############################################################################
#
# [rajesh@KdeDsk-ip65: ~]
#
# $ sshcpk <== shortcut in .bash_aliase
#
# $ . ssh-copy-pub-keyfile-to-remote-host.sh
#
# == Use Case -1 ============================================================
#
# [rajesh@KdeDsk-ip65: ~]
# $ sshcpk 102
# ...
# Check if Remote host is reachable before attempting SSH Copy...
# Check Ok: Remote host (192.168.1.102) is reachable
# ...
# Bash Script Start - Copy SSH Public Kefile to remote host...
# ...
# SSH Public keyfile found ==> /home/rajesh/.ssh/ssh-ed25519-rajesh@KdeDsk-ip65.pub
# ...
# Remote Host ==> admin@192.168.1.102
# ...
# /usr/bin/ssh-copy-id: INFO: Source of key(s) to be installed: "/home/rajesh/.ssh/ssh-ed25519-rajesh@KdeDsk-ip65.pub"
# /usr/bin/ssh-copy-id: INFO: attempting to log in with the new key(s), to filter out any that are already installed
# /usr/bin/ssh-copy-id: INFO: 1 key(s) remain to be installed -- if you are prompted now it is to install the new keys
# admin@192.168.1.102's password:
#
# Number of key(s) added: 1
#
# Now try logging into the machine, with:   "ssh 'admin@192.168.1.102'"
# and check to make sure that only the key(s) you wanted were added.
#
# ...
# Job Done exit...
# ...
#
# == Use Case -2 ============================================================
#
# [rajesh@KdeDsk-ip65: ~]
# $ sshcpk 102
# ...
# Check if Remote host is reachable before attempting SSH Copy...
# Check Ok: Remote host (192.168.1.102) is reachable
# ...
# Error: SSH Public keyfile Not found ==> /home/rajesh/.ssh/ssh-ed25519-rajesh@KdeDsk-ip65.pub
# Please use the (ssh-gen-keyfile-pair.sh) bash script to
# Generate a NEW SSH Private Public Keyfile Pair
# and then run this bash script
# ...
#
# == Use Case -3 ============================================================
#
# SSH key already exists on remote server. Skipping copy.
#
# [rajesh@KdeDsk-ip65: ~]
# $ sshcpk 102
# ...
# Check if Remote host is reachable before attempting SSH Copy...
# Check Ok: Remote host (192.168.1.102) is reachable
# ...
# Bash Script Start - Copy SSH Public Kefile to remote host...
# ...
# SSH Public keyfile to copy ==> /home/rajesh/.ssh/ssh-ed25519-rajesh@KdeDsk-ip65.pub
# ...
# Remote Host ==> admin@192.168.1.102
# ...
# /usr/bin/ssh-copy-id: INFO: Source of key(s) to be installed: "/home/rajesh/.ssh/ssh-ed25519-rajesh@KdeDsk-ip65.pub"
# /usr/bin/ssh-copy-id: INFO: attempting to log in with the new key(s), to filter out any that are already installed
#
# /usr/bin/ssh-copy-id: WARNING: All keys were skipped because they already exist on the remote system.
#                 (if you think this is a mistake, you may want to use -f option)
#
#
##############################################################################
