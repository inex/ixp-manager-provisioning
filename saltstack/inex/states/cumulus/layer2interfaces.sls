## Copyright (C) 2018 Internet Neutral Exchange Association Company Limited By Guarantee.
## All Rights Reserved.
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
