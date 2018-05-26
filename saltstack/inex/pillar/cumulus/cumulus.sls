{#-

## Copyright (C) 2018 Internet Neutral Exchange Association Company Limited By Guarantee.
## All Rights Reserved.
##
## cumulus.sls - handle Cumulus-specific parameters
##
## methodology:
##
##   - import cumulus license from variables.j2

#}

{%- from "variables.j2" import pvars with context %}

license: "{{ pvars.cumulus.license }}"
