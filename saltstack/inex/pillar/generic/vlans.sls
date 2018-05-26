{#-

## Copyright (C) 2018 Internet Neutral Exchange Association Company Limited By Guarantee.
## All Rights Reserved.
##
## vlans.sls - import VLAN parameters
##
## methodology:
##
##   - import this from IXP Manager API

#}

{%- from "variables.j2" import pvars with context %}

{{ salt['http.query'](pvars.apiroot + 'vlans/switch-name/' + pvars.myid + '.yaml', header_dict=pvars.headers).body }}
