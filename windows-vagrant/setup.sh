
echo ""

echo "###"
echo "#  RUN THESE COMMANDS (maybe?)"
echo "###"

echo ""

echo "# Set TMPDIR"
echo 'export TMPDIR="/bld/tmp"'

echo ""

echo "# Make 7z available ... "
echo "yum -y install p7zip"
echo "ln -s $(which 7za) /usr/local/bin/7z"

echo ""

echo "# install bsdtar"
echo "yum -y install bsdtar"

echo ""

