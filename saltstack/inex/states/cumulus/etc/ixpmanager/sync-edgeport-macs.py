#!/usr/bin/python
##
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
# FIXME: a mac address can appear on another interface.  E.g.  local mac
# address wired to swp1 could also be pinned to another interface where the
# mac address was auto-learned.  Fixing this may require knowledge of the
# interface topology and how that relates to the network config on the switch.
#

from subprocess import check_output
import json

def read_json(cmdlist):
  try:
    cmd_output = check_output(cmdlist)
  except Exception:
    cmd_output = '{}'

  try:
    json_output = json.loads(cmd_output)
  except Exception:
    json_output = {}

  return json_output

def convert_bridge_to_hier(inputbrinfo):
  macs = {}
  for entry in inputbrinfo:
    dev = entry['dev']

    if 'vlan' not in entry:
      entry['vlan'] = 1
    vlan = 'vl' + str(entry['vlan'])

    if dev not in macs:
      macs[dev] = {}

    if vlan not in macs[dev]:
      macs[dev][vlan] = {}

    macs[dev][vlan][entry['mac']] = json.dumps(entry, sort_keys=True)

  return macs

def bridge_modify(action, entry):

  print action,":", json.dumps(entry)

  # 24:8a:07:c8:64:7c dev swp15 master bridge permanent
  # ce:6b:30:10:64:47 dev swp15 vlan 12 master bridge
  # 30:b6:4f:e5:00:f2 dev swp15 vlan 12 master bridge static

  cmd = ['/sbin/bridge', 'fdb', action, str(entry['mac']), 'dev', str(entry['dev'])]

  if 'vlan' in entry and entry['vlan'] != 1:
    cmd.extend(['vlan', str(entry['vlan'])])

  if 'master' in entry:
    cmd.extend(['master'])

  if 'state' in entry:
    cmd.extend([str(entry['state'])])

  print cmd

  try:
    output = check_output(cmd)
  except Exception:
    print '... failed'
            
if __name__ == '__main__':
  fdb = read_json(['/sbin/bridge', '-j', 'fdb', 'show'])
  new = read_json(['/bin/cat', '/etc/network/fdb.json'])

  cur_fdb = convert_bridge_to_hier(fdb)
  new_fdb = convert_bridge_to_hier(new)

# convert_bridge_to_hier() will convert to this structure:
#
# {
#   "swp15": {
#     "vl1": {
#       "24:8a:07:c8:64:7c":"{\"dev\": \"swp15\", \"mac\": \"24:8a:07:c8:64:7c\", \"master\": \"bridge\", \"state\": \"permanent\", \"vlan\": 1}"
#     },
#     "vl12": {
#       "30:b6:4f:e5:00:f2":"{\"dev\": \"swp15\", \"mac\": \"30:b6:4f:e5:00:f2\", \"master\": \"bridge\", \"state\": \"static\", \"vlan\": 12}",
#       "ce:6b:30:10:64:47":"{\"dev\": \"swp15\", \"mac\": \"ce:6b:30:10:64:47\", \"master\": \"bridge\", \"vlan\": 12}"
#     }
#   }
# }

  # ignore any switchport which isn't defined in new_fdb
  for dev in cur_fdb.keys():

    if dev not in new_fdb:
      del cur_fdb[dev]

  # for the remaining mac entries, iterate through all the entries in
  # new_fdb.  If there is an exact match in cur_fdb, then delete the entries
  # in both new_fdb and cur_fdb.

  for dev in new_fdb.keys():
    if dev in cur_fdb:
      for vlan in new_fdb[dev].keys():
        for mac in new_fdb[dev][vlan].keys():
          if mac in cur_fdb[dev][vlan] and cur_fdb[dev][vlan][mac] == new_fdb[dev][vlan][mac]:
            del cur_fdb[dev][vlan][mac]
            del new_fdb[dev][vlan][mac]

  # when this process has finished, all the entries in cut_fdb should be
  # removed from the FDB, and all the entries in new_fdb should be added to
  # the FDB.

  for dev in cur_fdb.keys():
    for vlan in cur_fdb[dev].keys():
      for mac in cur_fdb[dev][vlan].keys():
        bridge_modify('del', json.loads(cur_fdb[dev][vlan][mac]))

  for dev in new_fdb.keys():
    for vlan in new_fdb[dev].keys():
      for mac in new_fdb[dev][vlan].keys():
        bridge_modify('add', json.loads(new_fdb[dev][vlan][mac]))
