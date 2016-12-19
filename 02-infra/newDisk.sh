lshw -class disk
lsscsi
fdisk -l
fdisk -c -u /dev/sdc
    n, p, 1, def, def, p, w
mkfs -t ext4 -m 1 /dev/sdc1
mkdir /data1
mount -t ext4 /dev/sdc1 /mnt/data
