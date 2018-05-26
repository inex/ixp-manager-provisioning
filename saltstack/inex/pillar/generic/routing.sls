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
## routing.sls - import information relating to layer 3 IXP core
##
## methodology:
##
##   - import this from IXP Manager API

#}

{%- from "variables.j2" import pvars with context %}

{{ salt['http.query'](pvars.apiroot + 'routing/switch-name/' + pvars.myid + '.yaml', header_dict=pvars.headers).body }}
