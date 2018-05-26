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
## frr.sls - handle Cumulus FRR configuration.
##
## methodology -
##
##   - ensure quagga is deleted, as the two packages cannot be installed on
##     the same device.
##   - rebuild frr.conf
##   - reload using systemd

quagga:
  pkg.removed

quagga-compat:
  pkg.removed

/etc/frr/daemons:
  file.managed:
    - source: salt://cumulus/etc/frr/daemons
    - name: /etc/frr/daemons

/etc/frr/frr.conf:
  file.managed:
    - source: salt://cumulus/etc/frr/frr.conf.j2
    - name: /etc/frr/frr.conf
    - template: jinja
  service.running:
    - name: frr
    - enable: True
    - reload: True
    - provider: systemd
    - watch:
       - file: /etc/frr/frr.conf
