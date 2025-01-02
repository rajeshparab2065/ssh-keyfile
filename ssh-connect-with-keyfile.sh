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
# (3) Connect to remote with Public-Key from Dvlpr-PC
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
# example keyfilename       /home/rajesh/.ssh/ssh-rajesh@lxdedsk-ip65-ed25519
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
  echo "sshk 75 [admin]"
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
echo 'Check if Remote host is reachable before Connecting...'
if ! check_remote_host_reachable; then
  echo 'exiting bash script'
  echo '...'
  return
fi
# --------------------------------------------------------------------
if ! [ -f "$ssh_keyfile_private" ]; then
  echo '...'
  echo "Error: SSH Private keyfile Not found ==> $ssh_keyfile_private"
  echo 'Please use the (ssh-gen-keyfile-pair.sh) bash script to'
  echo 'Generate a NEW SSH Private Public Keyfile Pair'
  echo 'and then run this bash script...'
  echo '...'
  return
fi
# -----------------------------------------------------------------
echo '...'
echo 'Bash Script Start - Connect with SSH Private Kefile to remote host...'
echo '...'
echo "SSH Private keyfile found ==> $ssh_keyfile_private"
echo '...'
echo "Remote Host ==> $remote_username@$remote_server_ip_address"
echo '...'
echo 'WARINING: if password prompt is asking for password'
echo 'it means you have not copied the public key to remote'
echo 'run this script ==> ssh-copy-pub-kefile-to-remote-host.sh'
echo 'press Ctrl+C and exit'
echo '...'
echo '...'

ssh -i $ssh_keyfile_private  $remote_username@$remote_server_ip_address

# EOF #
################################################################################
#
# [rajesh@KdeDsk-ip65: ~/rpa/installer/script/bash]
#
# $ sshk <== shortcut in .bash_aliase
#
# $ . ssh-connect-with-keyfile.sh 103
#
# == Use Case - 1 ============================================================
#
# [rajesh@KdeDsk-ip65: ~]
# $ sshck 102
# ...
# Check if Remote host is reachable before Connecting...
# Check Ok: Remote host (192.168.1.102) is reachable
# ...
# Bash Script Start - Connect with SSH Private Kefile to remote host...
# ...
# SSH Private keyfile found ==> /home/rajesh/.ssh/ssh-ed25519-rajesh@KdeDsk-ip65
# ...
# Remote Host ==> admin@192.168.1.102
# ...
# WARINING: if password prompt is asking for password
# it means you have not copied the public key to remote
# run this script ==> ssh-copy-pub-kefile-to-remote-host.sh
# press Ctrl+C and exit
# ...
# ...
# admin@192.168.1.102's password:
#
# press Ctrl+C
# run sshcpk 102
#
# == Use Case - 2 ============================================================
#
# [rajesh@KdeDsk-ip65: ~]
# $ sshck 102
# ...
# Check if Remote host is reachable before Connecting...
# Check Ok: Remote host (192.168.1.102) is reachable
# ...
# Bash Script Start - Connect with SSH Private Kefile to remote host...
# ...
# SSH Private keyfile found ==> /home/rajesh/.ssh/ssh-ed25519-rajesh@KdeDsk-ip65
# ...
# Remote Host ==> admin@192.168.1.102
# ...
# WARINING: if password prompt is asking for password
# it means you have not copied the public key to remote
# run this script ==> ssh-copy-pub-kefile-to-remote-host.sh
# press Ctrl+C and exit
# ...
# ...
# Linux Bookworm-Lite 6.6.20+rpt-rpi-v8 #1 SMP PREEMPT Debian 1:6.6.20-1+rpt1 (2024-03-07) aarch64
#
# The programs included with the Debian GNU/Linux system are free software;
# the exact distribution terms for each program are described in the
# individual files in /usr/share/doc/*/copyright.
#
# Debian GNU/Linux comes with ABSOLUTELY NO WARRANTY, to the extent
# permitted by applicable law.
# Last login: Thu May  2 14:10:10 2024 from 192.168.1.65
# admin@Bookworm-Lite ~
# $
#
################################################################################
