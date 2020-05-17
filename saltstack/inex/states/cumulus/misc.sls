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
## static.sls - handle Cumulus static configuration files.
##

/etc/network/ifupdown2/policy.d/interface.json:
  file.managed:
    - source: salt://cumulus/etc/network/ifupdown2/policy.d/interface.json.j2
    - name: /etc/network/ifupdown2/policy.d/interface.json
    - template: jinja

{% if salt['grains.get']('lsb_distrib_codename') == 'buster' %}
##
## restart ntp in default vrf and kill mgmt vrf instance
##

ntp-mgmt.service-kill:
  service.dead:
    - name: ntp@mgmt.service

ntp-mgmt.service-masked:
  service.masked:
    - name: ntp@mgmt.service

/etc/systemd/system/ntp.service.d:
  file.directory:
    - user: root
    - mode: 755
    - makedirs: true

/etc/systemd/system/ntp.service.d/override.conf:
  file.managed:
    - source: salt://cumulus/etc/systemd/system/ntp.service.d/override.conf
    - name: /etc/systemd/system/ntp.service.d/override.conf
  cmd.wait:
    - watch:
       - file: /etc/systemd/system/ntp.service.d/override.conf
    - name: 'systemctl daemon-reload'

{% endif %}
