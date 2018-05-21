## Copyright (C) 2018 Internet Neutral Exchange Association Company Limited By Guarantee.
## All Rights Reserved.
##
## sflow.sls - handle Cumulus sflow configuration
##
## methodology:
##
##   - create / update hsflowd.conf
##   - handle per-port sflow udpates using custom script in /etc/ixpmanager

/etc/hsflowd.conf:
  file.managed:
    - source: salt://cumulus/etc/hsflowd.conf.j2
    - name: /etc/hsflowd.conf
    - template: jinja
  service.running:
    - provider: systemd
    - watch:
       - file: /etc/hsflowd.conf
    - name: hsflowd

/etc/ixpmanager:
  file.directory:
    - user: root
    - mode: 755
    - makedirs: true

/etc/ixpmanager/restart_sflow.sh:
  file.managed:
    - source: salt://cumulus/etc/ixpmanager/restart_sflow.sh.j2
    - name: /etc/ixpmanager/restart_sflow.sh
    - user: root
    - mode: 755
    - template: jinja
  cmd.wait:
    - watch:
       - file: /etc/ixpmanager/restart_sflow.sh
    - name: '/etc/ixpmanager/restart_sflow.sh'
