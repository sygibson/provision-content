
echo ""

echo "###"
echo "#  RUN THESE COMMANDS (maybe?)"
echo "###"

echo ""

echo "# Set TMPDIR"
echo 'export TMPDIR="/bld/tmp"'

echo ""

echo "# install bsdtar"
echo "yum -y install bsdtar"

echo ""

echo "Setup vagrant/packer/packer-provisioner-windows-update-linux:"
echo ""
echo '
cd /usr/local/bin/
curl -s https://releases.hashicorp.com/packer/1.5.6/packer_1.5.6_linux_amd64.zip | zcat > packer && chmod 755 packer
curl -fsSL https://github.com/rgl/packer-provisioner-windows-update/releases/download/v0.9.0/packer-provisioner-windows-update-linux.tgz | tar -xzvf - && chmod 755  packer-provisioner-windows-update
curl -fsSL https://releases.hashicorp.com/vagrant/2.2.9/vagrant_2.2.9_linux_amd64.zip | zcat > vagrant && chmod 755 vagrant
'

