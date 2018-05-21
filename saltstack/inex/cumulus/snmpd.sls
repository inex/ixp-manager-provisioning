## Copyright (C) 2018 Internet Neutral Exchange Association Company Limited By Guarantee.
## All Rights Reserved.
##
## snmpd.sls - handle Cumulus SNMP configuration.
##
## methodology:
##
##   - create / update snmpd.conf.ixpmanager
##   - create device-specific information in salt pillar

/etc/snmp/snmpd.conf.ixpmanager:
  file.managed:
    - source: salt://cumulus/etc/snmp/snmpd.conf.ixpmanager.j2
    - name: /etc/snmp/snmpd.conf.ixpmanager
    - template: jinja
  service.running:
    - provider: systemd
    - enable: true
    - watch:
       - file: /etc/snmp/snmpd.conf.ixpmanager
    - name: snmpd

/etc/snmp/snmpd.conf:
  file.symlink:
    - target: /etc/snmp/snmpd.conf.ixpmanager
