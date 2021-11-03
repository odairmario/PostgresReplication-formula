# -*- coding: utf-8 -*-
# vim: ft=sls

{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- set sls_package_install = tplroot ~ '.package.install' %}
{%- from tplroot ~ "/map.jinja" import mapdata as pg with context %}
{%- from tplroot ~ "/libtofs.jinja" import files_switch with context %}

include:
  - {{ sls_package_install }}

postgresql-replication-config-file-file-managed:
  file.managed:
    - name: "{{ pg.config }}{{pg.major_version}}/main/postgresql.conf"
    - source: {{ files_switch(['postgresql.conf.jinja'],
                              lookup='postgresql-replication-config-file-file-managed'
                 )
              }}
    - mode: 644
    - user: root
    - group: {{ pg.rootgroup }}
    - makedirs: True
    - template: jinja
    - require:
      - sls: {{ sls_package_install }}
    - context:
        pg_data: {{ pg | json }}
