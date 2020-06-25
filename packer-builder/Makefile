# Disable builtin rules and variables since they aren't used
# This makes the output of "make -d" much easier to follow and speeds up evaluation
MAKEFLAGS+= --no-builtin-rules
MAKEFLAGS+= --no-builtin-variables

# Normal (libvirt and VirtualBox) images
IMAGES+= windows-2012-r2
IMAGES+= windows-2016
IMAGES+= windows-2019
IMAGES+= windows-2019-uefi
IMAGES+= windows-10
IMAGES+= windows-10-1903
IMAGES+= windows-10-1909
# linux
LIN_IMAGES+= ubuntu-1804

# Images supporting vSphere
VSPHERE_IMAGES+= windows-2016
VSPHERE_IMAGES+= windows-2019
VSPHERE_IMAGES+= windows-10

SETUP:=$(shell bash make-setup.sh)

# Generate build-* targets
#LIN_VIRTUALBOX_BUILDS= $(addsuffix -virtualbox,$(addprefix linux/$(LIN_IMAGES)/build-,$(LIN_IMAGES)))
#LIN_LIBVIRT_BUILDS= $(addsuffix -libvirt,$(addprefix linux/$(LIN_IMAGES)/build-,$(LIN_IMAGES)))
#LIN_VSPHERE_BUILDS= $(addsuffix -vsphere,$(addprefix linux/$(LIN_IMAGES)/build-,$(LIN_IMAGES)))

LIN_LIBVIRT_BUILDS= $(addsuffix -libvirt,$(addprefix linux-build-,$(LIN_IMAGES)))

VIRTUALBOX_BUILDS= $(addsuffix -virtualbox,$(addprefix build-,$(IMAGES)))
LIBVIRT_BUILDS= $(addsuffix -libvirt,$(addprefix build-,$(IMAGES)))
VSPHERE_BUILDS= $(addsuffix -vsphere,$(addprefix build-,$(VSPHERE_IMAGES)))

.PHONY: help $(VIRTUALBOX_BUILDS) $(LIBVIRT_BUILDS) $(VSPHERE_BUILDS)

help:
	@echo Type one of the following commands to build a specific windows box.
	@echo
	@echo VirtualBox Targets:
	@$(addprefix echo make ,$(addsuffix ;,$(LIN_VIRTUALBOX_BUILDS)))
	@$(addprefix echo make ,$(addsuffix ;,$(VIRTUALBOX_BUILDS)))
	@echo
	@echo libvirt Targets:
	@$(addprefix echo make ,$(addsuffix ;,$(LIN_LIBVIRT_BUILDS)))
	@$(addprefix echo make ,$(addsuffix ;,$(LIBVIRT_BUILDS)))
	@echo
	@echo vSphere Targets:
	@$(addprefix echo make ,$(addsuffix ;,$(LIN_VSPHERE_BUILDS)))
	@$(addprefix echo make ,$(addsuffix ;,$(VSPHERE_BUILDS)))

# Target specific pattern rules for build-* targets
$(LIN_VIRTUALBOX_BUILDS): linux/$(LIN_IMAGES)/build-%-virtualbox: %-amd64-virtualbox.box

#SYG
#$(LIN_LIBVIRT_BUILDS): linux/$(LIN_IMAGES)/build-%-libvirt: %-amd64-libvirt.box
$(LIN_LIBVIRT_BUILDS): linux-build-%-libvirt: %-amd64-libvirt.box

$(LIN_VSPHERE_BUILDS): linux/$(LIN_IMAGES)/build-%-vsphere: %-amd64-vsphere.box

$(VIRTUALBOX_BUILDS): build-%-virtualbox: %-amd64-virtualbox.box
$(LIBVIRT_BUILDS): build-%-libvirt: %-amd64-libvirt.box
$(VSPHERE_BUILDS): build-%-vsphere: %-amd64-vsphere.box

linux-%-amd64-virtualbox.box: linux/%.json
	rm -f $@
	CHECKPOINT_DISABLE=1 PACKER_LOG=1 PACKER_LOG_PATH=$*-amd64-virtualbox-packer.log \
		packer build $(PACKER_OPTIONS) -only=$*-amd64-virtualbox -on-error=abort $*.json
	@echo BOX successfully built!
	@echo to add to local vagrant install do:
	@echo vagrant box add -f $*-amd64 $@

#ubuntu-1804-amd64-libvirt.box
#linux-%-amd64-libvirt.box: linux/%.json
%-amd64-libvirt.box: linux/%.json
	cd linux
	rm -f $@
	CHECKPOINT_DISABLE=1 PACKER_LOG=1 PACKER_LOG_PATH=$*-amd64-libvirt-packer.log \
		packer build $(PACKER_OPTIONS) -only=$*-amd64-libvirt -on-error=abort $*.json
	@echo BOX successfully built!
	@echo to add to local vagrant install do:
	@echo vagrant box add -f $*-amd64 $@

%-amd64-virtualbox.box: %.json %/autounattend.xml Vagrantfile.template *.ps1 drivers
	rm -f $@
	CHECKPOINT_DISABLE=1 PACKER_LOG=1 PACKER_LOG_PATH=$*-amd64-virtualbox-packer.log \
		packer build $(PACKER_OPTIONS) -only=$*-amd64-virtualbox -on-error=abort $*.json
	./get-windows-updates-from-packer-log.sh \
		$*-amd64-virtualbox-packer.log \
		>$*-amd64-virtualbox-windows-updates.log
	@echo BOX successfully built!
	@echo to add to local vagrant install do:
	@echo vagrant box add -f $*-amd64 $@

%-amd64-libvirt.box: %.json %/autounattend.xml Vagrantfile.template *.ps1 drivers
	rm -f $@
	CHECKPOINT_DISABLE=1 PACKER_LOG=1 PACKER_LOG_PATH=$*-amd64-libvirt-packer.log \
		packer build $(PACKER_OPTIONS) -only=$*-amd64-libvirt -on-error=abort $*.json
	./get-windows-updates-from-packer-log.sh \
		$*-amd64-libvirt-packer.log \
		>$*-amd64-libvirt-windows-updates.log
	@echo BOX successfully built!
	@echo to add to local vagrant install do:
	@echo vagrant box add -f $*-amd64 $@

%-uefi-amd64-virtualbox.box: %-uefi.json %-uefi/autounattend.xml Vagrantfile-uefi.template *.ps1 drivers %-uefi-amd64-virtualbox.iso
	rm -f $@
	cp /usr/share/OVMF/x64/OVMF_VARS.fd $*-uefi-amd64-virtualbox.nvram
	CHECKPOINT_DISABLE=1 PACKER_LOG=1 PACKER_LOG_PATH=$*-uefi-amd64-virtualbox-packer.log \
		packer build $(PACKER_OPTIONS) -only=$*-uefi-amd64-virtualbox -on-error=abort $*-uefi.json
	./get-windows-updates-from-packer-log.sh \
		$*-uefi-amd64-virtualbox-packer.log \
		>$*-uefi-amd64-virtualbox-windows-updates.log
	@echo BOX successfully built!
	@echo to add to local vagrant install do:
	@echo vagrant box add -f $*-uefi-amd64 $@

%-uefi-amd64-libvirt.box: %-uefi.json %-uefi/autounattend.xml Vagrantfile-uefi.template *.ps1 drivers
	rm -f $@
	cp /usr/share/OVMF/OVMF_VARS.fd $*-uefi-amd64-libvirt.nvram
	CHECKPOINT_DISABLE=1 PACKER_LOG=1 PACKER_LOG_PATH=$*-uefi-amd64-libvirt-packer.log \
		packer build $(PACKER_OPTIONS) -only=$*-uefi-amd64-libvirt -on-error=abort $*-uefi.json
	./get-windows-updates-from-packer-log.sh \
		$*-uefi-amd64-libvirt-packer.log \
		>$*-uefi-amd64-libvirt-windows-updates.log
	@echo BOX successfully built!
	@echo to add to local vagrant install do:
	@echo vagrant box add -f $*-uefi-amd64 $@

windows-2019-uefi-amd64-virtualbox.iso: windows-2019-uefi/autounattend.xml winrm.ps1
	xorrisofs -J -R -input-charset ascii -o $@ $^

tmp/%-vsphere/autounattend.xml: %/autounattend.xml
	mkdir -p "$$(dirname $@)"
	@# add the vmware tools iso to the drivers search path.
	@# NB we cannot have this in the main autounattend.xml because windows 2016
	@#    will fail to install when the virtualbox guest additions iso is in E:
	@#    with the error message:
	@#        Windows Setup could not install one or more boot-critical drivers.
	@#        To install Windows, make sure that the drivers are valid, and
	@#        restart the installation.
	sed -E 's,(.+)</DriverPaths>,\1    <PathAndCredentials wcm:action="add" wcm:keyValue="2"><Path>E:\\</Path></PathAndCredentials>\n\0,g' $< >$@

%-amd64-vsphere.box: %-vsphere.json tmp/%-vsphere/autounattend.xml Vagrantfile.template *.ps1
	rm -f $@
	CHECKPOINT_DISABLE=1 PACKER_LOG=1 PACKER_LOG_PATH=$*-amd64-vsphere-packer.log \
		packer build $(PACKER_OPTIONS) -only=$*-amd64-vsphere -on-error=abort $*-vsphere.json
	./get-windows-updates-from-packer-log.sh \
		$*-amd64-vsphere-packer.log \
		>$*-amd64-vsphere-windows-updates.log
	@echo 'Removing all cd-roms (except the first)...'
	govc device.ls "-vm.ipath=$$VSPHERE_TEMPLATE_IPATH" \
		| grep ^cdrom- \
		| tail -n+2 \
		| awk '{print $$1}' \
		| xargs -L1 govc device.remove "-vm.ipath=$$VSPHERE_TEMPLATE_IPATH"
	@echo 'Converting to template...'
	govc vm.markastemplate "$$VSPHERE_TEMPLATE_IPATH"
	@echo 'Creating the local box file...'
	rm -rf tmp/$@-contents
	mkdir -p tmp/$@-contents
	echo '{"provider":"vsphere"}' >tmp/$@-contents/metadata.json
	cp Vagrantfile.template tmp/$@-contents/Vagrantfile
	tar cvf $@ -C tmp/$@-contents .
	@echo BOX successfully built!
	@echo to add to local vagrant install do:
	@echo vagrant box add -f $*-amd64 $@

# Windows 10 1903/1909 depends on the same autounattend as Windows 10
# This allows the use of pattern rules by satisfying the prerequisite
.PHONY: windows-10-1903/autounattend.xml windows-10-1909/autounattend.xml

drivers:
	rm -rf drivers.tmp
	mkdir -p drivers.tmp
	@# see https://docs.fedoraproject.org/en-US/quick-docs/creating-windows-virtual-machines-using-virtio-drivers/index.html
	@# see https://github.com/virtio-win/virtio-win-guest-tools-installer
	@# see https://github.com/crobinso/virtio-win-pkg-scripts
	wget -P drivers.tmp https://fedorapeople.org/groups/virt/virtio-win/direct-downloads/archive-virtio/virtio-win-0.1.173-8/virtio-win-0.1.173.iso
#	7z x -odrivers.tmp drivers.tmp/virtio-win-*.iso
	bsdtar -C drivers.tmp -xzvf drivers.tmp/virtio-win-*.iso
	mv drivers.tmp drivers
