## Copyright (C) 2018 Internet Neutral Exchange Association Company Limited By Guarantee.
## All Rights Reserved.
##
## layer3interfaces.sls - handle Cumulus core interfaces.
##
## methodology:
##
##   - create layer2interfaces.intf
##   - update if necessary using ifreload -a

/etc/network/interfaces.d/layer3interfaces.intf:
  file.managed:
    - source: salt://cumulus/etc/network/interfaces.d/layer3interfaces.intf.j2
    - name: /etc/network/interfaces.d/layer3interfaces.intf
    - template: jinja
  cmd.wait:
    - watch:
       - file: /etc/network/interfaces.d/layer3interfaces.intf
    - name: '/sbin/ifreload -a'
