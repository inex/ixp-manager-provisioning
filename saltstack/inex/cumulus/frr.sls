## Copyright (C) 2018 Internet Neutral Exchange Association Company Limited By Guarantee.
## All Rights Reserved.
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
