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
## fdb.sls - Cumulus bridge forwarding database json dump
##
## methodology:
##
##   - create fdb.json from j2 template
##   - update per-port forwarding database using sync-edgeport-macs.py

/etc/network/fdb.json:
  file.managed:
    - source: salt://cumulus/etc/network/fdb.json.j2
    - name: /etc/network/fdb.json
    - template: jinja

/etc/ixpmanager/sync-edgeport-macs.py:
  file.managed:
    - source: salt://cumulus/etc/ixpmanager/sync-edgeport-macs.py
    - name: /etc/ixpmanager/sync-edgeport-macs.py
    - user: root
    - mode: 755
# FIXME: this is complex to get working reliably
#  cmd.wait:
#    - watch:
#       - file: /etc/network/fdb.json
#    - name: '/etc/ixpmanager/sync-edgeport-macs.py'
