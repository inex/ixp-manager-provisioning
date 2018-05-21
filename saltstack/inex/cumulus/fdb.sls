## Copyright (C) 2018 Internet Neutral Exchange Association Company Limited By Guarantee.
## All Rights Reserved.
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
  cmd.wait:
    - watch:
       - file: /etc/network/fdb.json
    - name: '/etc/ixpmanager/sync-edgeport-macs.py'