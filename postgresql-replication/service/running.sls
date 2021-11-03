# -*- coding: utf-8 -*-
# vim: ft=sls

{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- set sls_config_file = tplroot ~ '.config.file' %}
{%- from tplroot ~ "/map.jinja" import mapdata as pg with context %}

include:
  - {{ sls_config_file }}

postgresql-replication-service-running-service-running:
  service.running:
    - name: {{ pg.service.name }}@{{pg.major_version}}-main
    - enable: True
    - watch:
      - sls: {{ sls_config_file }}
