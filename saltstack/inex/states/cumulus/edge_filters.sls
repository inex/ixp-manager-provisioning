## Copyright (C) 2018 Internet Neutral Exchange Association Company Limited By Guarantee.
## All Rights Reserved.
##
## edge_filters.sls - handle Cumulus port filters
##
## methodology:
##
##   - update ixp-filter.rules from j2 template
##   - refresh with cl-acltool -i

/etc/cumulus/acl/policy.d/ixp-filter.rules:
  file.managed:
    - source: salt://cumulus/etc/cumulus/acl/policy.d/ixp-filter.rules.j2
    - name: /etc/cumulus/acl/policy.d/ixp-filter.rules
    - template: jinja
  cmd.wait:
    - watch:
       - file: /etc/cumulus/acl/policy.d/ixp-filter.rules
    - name: '/usr/cumulus/bin/cl-acltool -i'
