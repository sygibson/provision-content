# context-demo
Creates VMware ESXi BootEnv Creation context for Digital Rebar v4.1+
====================================================================

Video: not done yet

License Required
----------------

Contexts are a RackN licensed featue of the DRP 4.1+ platform.  Community users with a renewable RackN trial license (free with registration) can create 3 contexts.

Prereqs
-------

You must install the `docker-context` plugin for this training.  You must also install Docker.

Then, create TWO docker containers as follows:

    rm dockerfile
    cp esxi-bootenv-dockerfile dockerfile
    docker build -t digitalrebar/esxi-bootenv .

    rm dockerfile
    cp runner-dockerfile dockerfile
    docker build -t digitalrebar/runner .

    rm dockerfile

After these instructions, Docker will have images that are needed by the runner
and terraform contexts.

Install Content
---------------

To use this sample code, bundle and upload the content

  # optionally set RS_ENDPOINT and RS_KEY environment variables
	drpcli contents bundle context-demo.yaml
	drpcli contents upload context-demo.yaml


Create a Machine with `runner` BaseContext
------------------------------------------

To test the Context, create a machine that uses the `runner` as the BaseContext with the following command: `drpcli machines create '{"Name":"demo", "Meta":{"BaseContext":"runner"}}'`


Running VMware ESXi BootEnv Context
-----------------------------------


