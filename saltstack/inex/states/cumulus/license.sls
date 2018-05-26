## Copyright (C) 2018 Internet Neutral Exchange Association Company Limited By Guarantee.
## All Rights Reserved.
##
## license.sls - handle Cumulus Linux licensing.
##
## methodology -
##
##   - use pillar.get('license') to retrieve license
##   - pipe into cl-license -i
##   - if any changes, then restart switchd

license:
  cmd:
    - run
    - name: "echo '{{ salt['pillar.get']('license') }}' | /usr/cumulus/bin/cl-license -i"
    - unless: /usr/cumulus/bin/cl-license

switchd:
  service.running:
    - enable: true
    - provider: systemd
    - watch:
      - license
