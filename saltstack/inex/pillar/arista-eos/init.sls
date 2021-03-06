{#-

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
## init.sls - import all the saltstack SLS state files

#}
{%- from "variables.j2" import pvars with context %}

include:
  - {{ pvars.myid }}.proxy
  - {{ pvars.myid }}.routing
  - {{ pvars.myid }}.layer2interfaces
  - {{ pvars.myid }}.layer3interfaces
  - {{ pvars.myid }}.vlans
  - {{ pvars.myid }}.switch
