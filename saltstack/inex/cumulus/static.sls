## Copyright (C) 2018 Internet Neutral Exchange Association Company Limited By Guarantee.
## All Rights Reserved.
##
## static.sls - handle Cumulus static configuration files.
##

/etc/network/ifupdown2/policy.d/interface.json:
  file.managed:
    - source: salt://cumulus/etc/network/ifupdown2/policy.d/interface.json
    - name: /etc/network/ifupdown2/policy.d/interface.json
