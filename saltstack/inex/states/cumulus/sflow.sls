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
## sflow.sls - handle Cumulus sflow configuration
##
## methodology:
##
##   - create / update hsflowd.conf
##   - handle per-port sflow udpates using custom script in /etc/ixpmanager

/etc/hsflowd.conf:
  file.managed:
    - source: salt://cumulus/etc/hsflowd.conf.j2
    - name: /etc/hsflowd.conf
    - template: jinja
  service.running:
    - provider: systemd
    - watch:
       - file: /etc/hsflowd.conf
    - name: hsflowd

/etc/ixpmanager:
  file.directory:
    - user: root
    - mode: 755
    - makedirs: true

/etc/ixpmanager/restart_sflow.sh:
  file.managed:
    - source: salt://cumulus/etc/ixpmanager/restart_sflow.sh.j2
    - name: /etc/ixpmanager/restart_sflow.sh
    - user: root
    - mode: 755
    - template: jinja
  cmd.wait:
    - watch:
       - file: /etc/ixpmanager/restart_sflow.sh
    - name: '/etc/ixpmanager/restart_sflow.sh'
