#!/sbin/sh
#
# silly little script to try and copy the ROM's system and vendor prop files to /tmp/
#

setenforce 0

sleep 1
vendor=$(readlink /dev/block/by-name/vendor)
[ -z "$vendor" ] && vendor=$(readlink /dev/block/by-name/cust)
[ -n "$vendor" ] && {
   mkdir -p /tmp/ven /tmp/vendor
   mount -r $vendor /tmp/ven
   cp /tmp/ven/*.prop /tmp/vendor
   umount /tmp/ven
   rmdir /tmp/ven
}

sleep 1
system=$(readlink /dev/block/by-name/system)
[ -z "$system" ] && system=$(readlink /dev/block/by-name/system_root)
[ -n "$system" ] && {
   mkdir -p /tmp/sys /tmp/system
   mount -r $system /tmp/sys
   cp /tmp/sys/*.prop /tmp/system
   [ -d /tmp/sys/system ] && cp /tmp/sys/system/*.prop /tmp/system
   umount /tmp/sys
   rmdir /tmp/sys
}

#
