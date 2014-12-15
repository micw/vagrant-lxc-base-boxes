#!/bin/bash
set -e

source common/ui.sh
source common/utils.sh

debug 'Bringing container up'
utils.lxc.start

info "Cleaning up '${CONTAINER}'..."

log 'Removing temporary files...'
rm -rf ${ROOTFS}/tmp/*

log 'removing nameserver settings'
echo '' > ${ROOTFS}/etc/resolv.conf

echo -e "auto lo\niface lo inet loopback" > ${ROOTFS}/etc/network/interfaces

rm -f ${ROOTFS}/etc/ssh/*key*

log 'cleaning up dhcp leases'
rm -f ${ROOTFS}/var/lib/dhcp/*

log 'Removing downloaded packages...'
utils.lxc.attach apt-get clean
