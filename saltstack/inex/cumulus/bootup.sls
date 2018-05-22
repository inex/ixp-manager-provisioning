## Copyright (C) 2018 Internet Neutral Exchange Association Company Limited By Guarantee.
## All Rights Reserved.
##
## rc.local.sls - startup configuration for Cumulus Linux
##

/etc/rc.local:
  file.managed:
    - source: salt://cumulus/etc/rc.local
    - name: /etc/rc.local
    - user: root
    - mode: 755

/etc/rc.local.d:
  file.directory:
    - user: root
    - mode: 755
    - makedirs: true

/etc/rc.local.d/10-initialise-sflow:
  file.symlink:
    - target: /etc/ixpmanager/restart_sflow.sh
