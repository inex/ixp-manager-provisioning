## Copyright (C) 2018 Internet Neutral Exchange Association Company Limited By Guarantee.
## All Rights Reserved.
##
## This file is part of IXP Manager.
##
## IXP Manager is free software: you can redistribute it and/or modify it
## under the terms of the GNU General Public License as published by the Free
## Software Foundation, version 2.0 of the License.
##
## IXP Manager is distributed in the hope that it will be useful, but WITHOUT
## ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
## FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
## more details.
##
## You should have received a copy of the GNU General Public License v2.0
## along with IXP Manager.  If not, see:
##
## http://www.gnu.org/licenses/gpl-2.0.html
##
## --
##
## rc.local.sls - startup configuration for Cumulus Linux
##

/etc/rc.local:
  file.managed:
    - source: salt://cumulus/etc/rc.local
    - name: /etc/rc.local
    - user: root
    - mode: 755

/etc/rc.local.d:
  file.directory:
    - user: root
    - mode: 755
    - makedirs: true

#/etc/rc.local.d/10-initialise-fdb:
#  file.symlink:
#    - target: /etc/ixpmanager/sync-edgeport-macs.py

/etc/rc.local.d/20-initialise-sflow:
  file.symlink:
    - target: /etc/ixpmanager/restart_sflow.sh
