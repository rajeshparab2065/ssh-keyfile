# ssh-keyfile
Bash script to make a SSH Connection to Remote Host on LAN using last 2 or 3 digit of the local ip-address

~/installer/script/bash/ssh-keyfile/

bash script to make a SSH Connection to remote host on LAN
using last 2 or 3 digit of the ip-address, username

- ssh-connect-with-keyfile.sh ==> Connect to remote with Public-Key from Dvlpr-PC
- ssh-copy-pub-keyfile-to-remote-host.sh ==> Copy Public-Key from Dvlpr-PC to Remote-Host
- ssh-gen-keyfile-pair.sh ==> Generate SSH Key Pair on Server
- ssh-reset-known-hosts.sh ==> Remove old key entry from localhost/.ssh/known_hosts for

- example useage:
- LAN ip-address = 192.168.1.71
- username = ganesh
- you have to give only below command to make the SSH Connection to Remote
- command $ ./ssh-connect-with-keyfile.sh 71 ganesh

SSH Key-File-Name Format is defined as below
ssh_keyfilename = StartTag + host_user + @ + host_name + cEndTag
example ==> ssh-ganesh@hostname-ed25519

- in each script this variables are customized by developer

host_name=$(hostname)
host_user=$USER
ssh_keyfile_path="$HOME/.ssh"
ssh_keytype="ed25519"  # VALID options are RSA, DSA, ECDSA, and ed25519
cStartTag="ssh-"
cEndTag="-ed25519"

How to Use this bash script on a developer workstation

1. git clone ssh-keyfile repository into developer desktop user home dir eg below
2. alias sshk='. ~/installer/script/bash/ssh-keyfile/ssh-connect-with-keyfile.sh'
3. sshk 81 admin
