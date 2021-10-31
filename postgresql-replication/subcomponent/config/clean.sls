# -*- coding: utf-8 -*-
# vim: ft=sls

{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- set sls_service_clean = tplroot ~ '.service.clean' %}
{%- from tplroot ~ "/map.jinja" import mapdata as postgresql__replication with context %}

include:
  - {{ sls_service_clean }}

postgresql-replication-subcomponent-config-clean-file-absent:
  file.absent:
    - name: {{ postgresql__replication.subcomponent.config }}
    - watch_in:
        - sls: {{ sls_service_clean }}
