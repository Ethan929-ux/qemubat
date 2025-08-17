# qemubat
a bat file that saves and launchs qemu virtual machines
hasnt been tested on linux yet but works on windows
When starting for the first time: a folder called VMs will be made, make sure disks and isos are in that folder or else the vm wont launch if the path to the iso/disk change
the bat reads from .cfg in VMs folder
make sure you change the qemu path or put qemus folder in environmental variables:
locate the qemu folder (you need qemu installed obviously) then win + R and type sysdm.cpl, go to the advanced tab and environmental variables, under system variables, locate PATH and click edit. then you can put the qemu folder there

if there are any issues with parameters go into the .cfg and fix it, a normal one should look like this: (onedrive not recommended)

DISK=C:\Users\idk\OneDrive\Desktop\kali-disk.qcow2
DISKSIZE=40G
ISO=C:\Users\idk\OneDrive\Desktop\kali-linux-2025.2-installer-amd64.iso
RAM=4096
CPUS=2

more settings coming soon
