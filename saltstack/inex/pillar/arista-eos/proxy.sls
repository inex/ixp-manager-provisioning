{#-

## Copyright (C) 2018 Internet Neutral Exchange Association Company Limited By Guarantee.
## All Rights Reserved.
##
## proxy.sls - NAPALM salt proxy configuration for saltstack
##
## methodology:
##
##   - specify local parameters in variables.j2

#}

{%- from "variables.j2" import pvars with context %}

proxy:
  proxytype: napalm
  driver: eos
  host: {{ pvars.myid }}
  username: {{ pvars.proxy.username }}
  passwd: {{ pvars.proxy.passwd }}
  optional_args:
    enable_password: {{ pvars.proxy.enable }}
