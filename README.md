# IXP Manager Provisioning Templates

This is what INEX uses internally for device provisioning.

## Warning

These templates come without support and anyone even thinking about using
this right now should seriously rethink because they depend on
non-finalised, unreleased, and unsupported API endpoints in IXP Manager and
GUI support which is currently not available.

You are welcome to have a look at what's here and contribute feedback via
the issues page or the ixpmanager mailing list.  Having said that,
provisioning is complicated and very specific to individual IXPs.  Even if
your IXP is running with the same two network operating systems that are in
this repo, INEX doesn't have the resources to be able to make this work for
you.  We'll be polite about it, but please try to understand that this is
complicated stuff and this is early release stage code.

## Overview

These templates provide configuration support for Arista EOS and Cumulus
Linux 3.4+ devices using SaltStack.

The Arista EOS implementation uses NAPALM and can be easily modified for any
other operating system which supports either NAPALM or netmiko.

The Cumulus Linux template implementation uses native SaltStack support, and
treats the Cumulus Linux switch like any other Linux device.  For an IXP,
you need CL >= 3.4.2.

At the bare minimum, in order to make these work, you will need to be
completely fluent with NAPALM and advanced use of SaltStack, including how
to configure and maintain salt proxies.  If you have multiple IXP
configurations (e.g.  live / test environments), you will also need to be
fluent with the idea of multiple salt environments.

A good starting point would be Mircea Ulinic's guides for integrating
SaltStack and NAPALM:

https://mirceaulinic.net/2017-02-14-network-automation-tutorial/

For a bigger-picture overview about how these templates hang together, we've
done some presentations, e.g. Apricot 2018:

https://2018.apricot.net/assets/files/APNT806/inex-apricot-ixp-automation-2018.pdf
https://www.youtube.com/watch?v=AoJlCl4ngk0#t=37m47s

Note that there is no information in these presentations about the nitty
gritty of getting all this stuff to work.  The Apricot 2018 presentation
involves lots of cheery handwaving and high level overview stuff, but very
little detail other than some sample command-lines that we use.

## Limitations

Probably the templates will work without too many modifications with
Ansible, but we don't use Ansible at INEX so have zero clue about that.

There are some limitations with the current provisioning templates which
we'll fix in time, e.g.  lack of support for quarantine vlans, bgp
traffic engineering and BGP session teardown using ebtables / ACLs.

The API handles and most of the code has been written in IXP Manager, but
there are going to be significant code changes before IXP Manager 5 is
released, hence the warnings about total lack of support for this
repository.

