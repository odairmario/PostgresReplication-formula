# -*- coding: utf-8 -*-
# vim: ft=sls

{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- set sls_package_install = tplroot ~ '.package.install' %}
{%- from tplroot ~ "/map.jinja" import mapdata as postgresql__replication with context %}
{%- from tplroot ~ "/libtofs.jinja" import files_switch with context %}

include:
  - {{ sls_package_install }}

postgresql-replication-config-file-file-managed:
  file.managed:
    - name: {{ postgresql__replication.config }}
    - source: {{ files_switch(['example.tmpl'],
                              lookup='postgresql-replication-config-file-file-managed'
                 )
              }}
    - mode: 644
    - user: root
    - group: {{ postgresql__replication.rootgroup }}
    - makedirs: True
    - template: jinja
    - require:
      - sls: {{ sls_package_install }}
    - context:
        postgresql__replication: {{ postgresql__replication | json }}
