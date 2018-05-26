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
## snmpd.sls - handle Cumulus SNMP configuration.
##
## methodology:
##
##   - create / update snmpd.conf.ixpmanager
##   - create / update snmpd defaults file
##   - create device-specific information in salt pillar

/etc/default/snmpd.ixpmanager:
  file.managed:
    - source: salt://cumulus/etc/default/snmpd.ixpmanager
    - name: /etc/default/snmpd.ixpmanager

/etc/default/snmpd:
  file.symlink:
    - target: /etc/default/snmpd.ixpmanager

/etc/snmp/snmpd.conf.ixpmanager:
  file.managed:
    - source: salt://cumulus/etc/snmp/snmpd.conf.ixpmanager.j2
    - name: /etc/snmp/snmpd.conf.ixpmanager
    - template: jinja

/etc/snmp/snmpd.conf:
  file.symlink:
    - target: /etc/snmp/snmpd.conf.ixpmanager

snmpd:
  service.running:
    - provider: systemd
    - enable: true
    - watch:
      - file: /etc/snmp/snmpd.conf
      - file: /etc/snmp/snmpd.conf.ixpmanager
      - file: /etc/default/snmpd
      - file: /etc/default/snmpd.ixpmanager
