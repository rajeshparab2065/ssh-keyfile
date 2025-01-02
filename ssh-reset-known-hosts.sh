#!/bin/bash
#
# 2024-03-14 Rajesh Parab
# 2024-04-22 Updated
# 2024-04-30 FRC
# 2024-05-09 Updated to run before Ansible Script
#
# $0 is the script name i.e. bash, $1 first ARG, $2 is second..
#
# Using chmod u+x scriptname make the script executable.
#
#######################################################################
# FULL ip_address=192.168.1.41
#
input_ipaddress_last_2digit="$1"
username="$2"        #---double Quote only---
networkmask="$3"

host_user=$USER  # only required in getting path

#---PARAMETER NOT PASSED THEN EXIT.---
if [ -z "$input_ipaddress_last_2digit" ]; then #---double Quote only---
	echo '...'
	echo 'Error !!! Required Parameter (Ip Address last 2 digit) ?'
  echo 'Optional Parameter [ username ] default=admin'
  echo 'Optional Parameter [ networkmask ] default=192.168.1'
  echo "sshrk 75 [ username ] [ 192.168.1 ]"
	echo '...'
  return
  #exit 1
fi
#---PARAMETER NOT PASSED THEN SET DEFAULT VALUE---
if [ -z "$username" ]; then
    username="admin"
fi
if [ -z "$networkmask" ]; then
    networkmask="192.168.1"
fi
#---Build FULL IP-Address--(old code)----------------------------
# ip_address="$networkmask.$input_ipaddress_last_2digit"
# printf "The known_hosts file only contains the fingerprints of the public keys of remote hosts.\n"
# printf ". \n"
# printf "Remove old key entry from localhost/.ssh/known_hosts for IP-Address ==> $ip_address \n"
# printf ".\n"
#
# ssh-keygen -f "/home/$host_user/.ssh/known_hosts" -R $ip_address
#
# printf "..\n"
#
# ssh $username@$ip_address

#----New Code on 2024-05-09--------------------------
ip_address="$networkmask.$input_ipaddress_last_2digit"
echo ''
echo 'Start bash script to reset-known-host...'
echo ''
echo 'Open file ==> /home/rajesh/.ssh/known_hosts'
echo ''
echo "Search fingerprint for Remote Host ==> $ip_address"
echo 'if found remove fingerprint...'
echo ''
ssh-keygen -f "/home/rajesh/.ssh/known_hosts" -R $ip_address
echo '...'
echo ''
echo 'Open file ==> /home/rajesh/.ssh/known_hosts'
echo ''
echo 'Add Remote host Public key to known_hosts file'
echo ''
ssh-keyscan -t ed25519 $ip_address | grep ssh-ed25519 >> /home/rajesh/.ssh/known_hosts
echo ''
echo 'Added Ok...'
echo ''
################################################################################
#
# [rajesh@KdeDsk-ip65: ~]
#
# $ sshrk 102 <== shortcut in .bash_aliase
#
# $ . ssh-reset-known-hosts.sh 102
# .
# Remove old key entry from localhost/.ssh/known_hosts for IP-Address ==> 192.168.1.102
# .
# Host 192.168.1.102 not found in /home/rajesh/.ssh/known_hosts
# .
# The authenticity of host '192.168.1.102 (192.168.1.102)' can't be established.
# ED25519 key fingerprint is SHA256:wMMCr5jIHtSqfC5uUci/lrlk+ux+AEmGl14qzXL8WDI.
# This key is not known by any other names.
# Are you sure you want to continue connecting (yes/no/[fingerprint])? yes
# Warning: Permanently added '192.168.1.102' (ED25519) to the list of known hosts.
# Linux Bookworm-Lite 6.6.20+rpt-rpi-v8 #1 SMP PREEMPT Debian 1:6.6.20-1+rpt1 (2024-03-07) aarch64
#
# The programs included with the Debian GNU/Linux system are free software;
# the exact distribution terms for each program are described in the
# individual files in /usr/share/doc/*/copyright.
#
# Debian GNU/Linux comes with ABSOLUTELY NO WARRANTY, to the extent
# permitted by applicable law.
# Last login: Tue Apr 30 23:38:57 2024 from 192.168.1.65
#
# admin@Bookworm-Lite:~ $
#
################################################################################

# EOF # EOF #
