# -*- coding: utf-8 -*-
# vim: ft=sls

{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import mapdata as postgresql__replication with context %}

postgresql-replication-package-install-pkg-installed:
  pkg.installed:
    - name: {{ postgresql__replication.pkg.name }}
