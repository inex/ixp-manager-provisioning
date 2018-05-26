## Copyright (C) 2018 Internet Neutral Exchange Association Company Limited By Guarantee.
## All Rights Reserved.
##
## snmpd.sls - handle Cumulus SNMP configuration.
##
## methodology:
##
##   - create / update snmpd.conf.ixpmanager
##   - create / update snmpd defaults file
##   - create device-specific information in salt pillar

/etc/default/snmpd.ixpmanager:
  file.managed:
    - source: salt://cumulus/etc/default/snmpd.ixpmanager
    - name: /etc/default/snmpd.ixpmanager

/etc/default/snmpd:
  file.symlink:
    - target: /etc/default/snmpd.ixpmanager

/etc/snmp/snmpd.conf.ixpmanager:
  file.managed:
    - source: salt://cumulus/etc/snmp/snmpd.conf.ixpmanager.j2
    - name: /etc/snmp/snmpd.conf.ixpmanager
    - template: jinja

/etc/snmp/snmpd.conf:
  file.symlink:
    - target: /etc/snmp/snmpd.conf.ixpmanager

snmpd:
  service.running:
    - provider: systemd
    - enable: true
    - watch:
      - file: /etc/snmp/snmpd.conf
      - file: /etc/snmp/snmpd.conf.ixpmanager
      - file: /etc/default/snmpd
      - file: /etc/default/snmpd.ixpmanager
