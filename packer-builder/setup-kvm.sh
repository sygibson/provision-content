#!/usr/bin/env bash

# quick and dirty setup of KVM to be used by packer

set -e

xiterr() { [[ $1 =~ ^[0-9]+$ ]] && { XIT=$1; shift; } || XIT=1; printf "FATAL: $*\n"; exit $XIT; }

main() {
  source /etc/os-release
  osfamily=$(echo "$ID" | tr -d '"' | cut -d '=' -f 2)

  case $osfamily in
    centos|redhat|rhel|fedora|oel) 
      inst=$(which yum 2> /dev/null)
      [[ -z "$inst" ]] && inst=$(which dnf 2> /dev/null)
      [[ -z "$inst" ]] && xiterr 1 "oops, how to install on '$osfamily'? (it ain't 'yum' or 'dnf')."
      PKGS="libvirt libvirt-python iptables-services virt-install OVMF"
      setup_redhat $VERSION_ID
      POST="ln -s /usr/share/OVMF/x86/OVMF_CODE.fd /usr/share/OVMF/OVMF.fd"
    ;;
    debian|ubuntu)
       inst=apt
       PKGS="qemu libvirt-bin python-libvirt vagrant-libvirt libvirt-clients libvirt-daemon-system qemu-kvm-spice virtinst ovmf"
       setup_debian $VERSION_ID
    ;;
    *) xiterr 1 "Ask my masters for help, I don't know what to do for '$osfamily'."
     ;;
  esac

  $inst -y install qemu-kvm libguestfs-tools bridge-utils iptables util-linux unbound curl wget jq virt-viewer spice-vdagent $PKGS

  virt-host-validate
}

setup_redhat() {
case $1 in
  7)
cat << EOF-REPO > /etc/yum.repos.d/CentOS-Virt.repo
# CentOS-Virt
[virt-libvirt-latest]
name=CentOS-$releasever - Virt Libvirt Latest
baseurl=http://mirror.centos.org/centos/7/virt/x86_64/libvirt-latest/
gpgcheck=1
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-7

[virt-kvm-common]
name=CentOS-$releasever - Virt KVM Common
#mirrorlist=http://mirrorlist.centos.org/?release=$releasever&arch=$basearch&repo=virt&infra=$infra
#baseurl=http://mirror.centos.org/centos/$releasever/virt/$basearch/
baseurl=http://mirror.centos.org/centos/7/virt/x86_64/kvm-common/
gpgcheck=1
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-7
EOF-REPO
    yum -y makecache
    yum -y install epel-release
  ;;
  *)
    xiterr 1 "Don't know how to do '$ID' version '$1' package repo setup for KVM. [in setup_redhat()]"
  ;;
esac

}

setup_debian() {
  apt update
}

main $*
exit $?
