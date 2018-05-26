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
## layer2interfaces.sls - handle Cumulus edge interfaces.
##
## methodology -
##
##   - create layer2interfaces.intf
##   - update if necessary using ifreload -a

/etc/network/interfaces.d/layer2interfaces.intf:
  file.managed:
    - source: salt://cumulus/etc/network/interfaces.d/layer2interfaces.intf.j2
    - name: /etc/network/interfaces.d/layer2interfaces.intf
    - template: jinja
  cmd.wait:
    - watch:
       - file: /etc/network/interfaces.d/layer2interfaces.intf
    - name: '/sbin/ifreload -a'
