{#-

## Copyright (C) 2018 Internet Neutral Exchange Association Company Limited By Guarantee.
## All Rights Reserved.
##
## layer2interfaces.sls - handle ixp core layer 3 interfaces
##
## methodology:
##
##   - import this from IXP Manager API

#}

{%- from "variables.j2" import pvars with context %}

{{ salt['http.query'](pvars.apiroot + 'layer3interfaces/switch-name/' + pvars.myid + '.yaml', header_dict=pvars.headers).body }}
