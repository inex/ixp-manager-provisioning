## Copyright (C) 2018 Internet Neutral Exchange Association Company Limited By Guarantee.
## All Rights Reserved.
##
## This file is part of IXP Manager.
##
## IXP Manager is free software: you can redistribute it and/or modify it
## under the terms of the GNU General Public License as published by the Free
## Software Foundation, version 2.0 of the License.
##
## IXP Manager is distributed in the hope that it will be useful, but WITHOUT
## ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
## FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
## more details.
##
## You should have received a copy of the GNU General Public License v2.0
## along with IXP Manager.  If not, see:
##
## http://www.gnu.org/licenses/gpl-2.0.html
##
## --
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
