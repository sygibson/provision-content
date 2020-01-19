FaaSD on Raspberry PI Content Pack
==================================

This content provides deployment and operational workflows to manage the OpenFaaS service
on Raspberry Pi (RPi) platforms.  It is based on the excellent OpenFaas/FaasD work that
Alex Ellis has done, and the original blog/install post by him, located at:

  * https://blog.alexellis.io/faasd-for-lightweight-serverless/


Digital Rebar Platform
----------------------

This content pack is designed to be deployed with the Digital Rebar Platform (DRP), maintained
by RackN.  If you do not have DRP installed, you can check out the Quickstart documentation
at:

  * https://portal.rackn.io/

In addition, this content pack is designed to run on Raspberry Pi platforms.  This content
pack was tested and built, using the Open Edge Lab reference hardware and build, designed to
be driven by the Digital Rebar solution.  You can find more information on Open Edge Lab, at:

  * https://github.com/digitalrebar/edgelab


Platform Requirements
---------------------

This content and the FaaSD installation is aimed specifically at Raspberry Pi platforms.  This
content pack has been tested with the Digital Rebar AARCH64 (ARMHF) Sledgehammer OS build.  It
was written to be tolerant of Redhat based and Ubuntu based platform installs.  However, primary
testing was completed on the Sledgehammer platform - which is a customized CentOS 7 distro.

If you are testing on Debian/Ubuntu distros, you may need to adjust some of the tooling.  Please
Fork and provide a pull request back to the original source tree (sygibson/faasd-rpi) with any
enhancements.

The Raspberry Pi platforms used were specifically 4b variants with 4 GB memory.  Since the
Sledgehammer OS environment is purely in-memory (RAM boot / live boot) - the extra memory is
necessary since the filesystem structures are carved out of memory space.  This is not a
requirement for use of the system.  An installed to SD card OS should work equally well, and
reduce the memory requirement.


Operating This Content
----------------------

There is one primary Workflow for installing the FaaSD solution, called ``faasd-install``.  This
workflow installs and records the username/password basic auth information to interact with a
single FaaSD service.

In addition to the main install Workflow, there is ``faasd-test`` Workflow, which performs an
installation, along with the following validation tests of the service:

  * ``faas-cli store list`` - see what functions are available in the public store
  * deploy the ``NodeInfo`` function to the service
  * test the operation of the ``NodeInfo`` function


Future Enhancements
-------------------

Here are a few future enhancement possibilities for this content pack:

  * write a Context that installs a reverse proxy on the DRP Endpoint to create a
    load balanced access to the Machine members in the cluster
  * more operational workflows to extend daily interaction/operation of the cluster
  * determine if this tooling can be easily extrapolated to a non-platform (x86_64 vs arm)
    hardware install and management process
  * Parameterize the Versions that are installed, with tested/safe defaults
  * Determine if the ``install`` stage could be better broken out to discrete taks for reusability


Installation Reference
----------------------

The initial installation process was modeled after Alex Ellis's ``FaaSD for Lightweight Serverless``
posting, which can be found at:

  * https://blog.alexellis.io/faasd-for-lightweight-serverless/

More operational and use patterns can be found on that page, after the installation instructions.

