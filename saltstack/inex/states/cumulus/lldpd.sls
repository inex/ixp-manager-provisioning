## Copyright (C) 2018 Internet Neutral Exchange Association Company Limited By Guarantee.
## All Rights Reserved.
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
