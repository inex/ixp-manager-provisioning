{%- from "variables.j2" import pvars with context %}

include:
  - {{ pvars.myid }}.proxy
  - {{ pvars.myid }}.routing
  - {{ pvars.myid }}.layer2interfaces
  - {{ pvars.myid }}.layer3interfaces
  - {{ pvars.myid }}.vlans
  - {{ pvars.myid }}.switch
