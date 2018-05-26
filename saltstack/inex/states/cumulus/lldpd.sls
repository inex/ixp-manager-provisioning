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
## lldpd.sls - LLDP configuration
##

/etc/lldpd.d/lldpd.conf:
  file.managed:
    - source: salt://cumulus/etc/lldpd.conf.j2
    - name: /etc/lldpd.d/lldpd.conf
    - template: jinja
  cmd.wait:
    - watch:
       - file: /etc/lldpd.d/lldpd.conf
    - name: '/usr/sbin/lldpctl reload'

/etc/default/lldpd:
  file.managed:
    - source: salt://cumulus/etc/default/lldpd.j2
    - name: /etc/default/lldpd
    - template: jinja
  cmd.wait:
    - watch:
       - file: /etc/default/lldpd
    - name: 'systemctl restart lldpd.service'
