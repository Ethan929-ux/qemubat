# qemubat
a bat file that saves and launchs qemu virtual machines

When starting for the first time: a folder called VMs will be made, make sure disks and isos are in that folder or else the vm wont launch if the path to the iso/disk change

if there are any issues with parameters go into the .cfg and fix it, a normal one should look like this: (onedrive not recommended)

DISK=C:\Users\idk\OneDrive\Desktop\kali-disk.qcow2
DISKSIZE=40G
ISO=C:\Users\idk\OneDrive\Desktop\kali-linux-2025.2-installer-amd64.iso
RAM=4096
CPUS=2
