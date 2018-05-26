{#-

## Copyright (C) 2018 Internet Neutral Exchange Association Company Limited By Guarantee.
## All Rights Reserved.
##
## init.sls - import all the saltstack SLS state files

#}
{%- from "variables.j2" import pvars with context %}

include:
  - {{ pvars.myid }}.cumulus
  - {{ pvars.myid }}.routing
  - {{ pvars.myid }}.layer2interfaces
  - {{ pvars.myid }}.layer3interfaces
  - {{ pvars.myid }}.vlans
  - {{ pvars.myid }}.switch
