# -*- coding: utf-8 -*-
# vim: ft=sls

{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- set sls_config_clean = tplroot ~ '.config.clean' %}
{%- from tplroot ~ "/map.jinja" import mapdata as postgres with context %}

include:
  - {{ sls_config_clean }}

postgresql-replication-package-clean-pkg-removed:
  pkg.removed:
    - name: {{ postgres.pkg.name }}
    - require:
      - sls: {{ sls_config_clean }}


{% if grains.os_family == 'Debian' %}
postgresql-replication-package-removed-source-list:
  pkgrepo.absent:
    - name: {{postgres.pkgrepo.name}}
{% endif %}

