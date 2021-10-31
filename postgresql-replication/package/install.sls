# -*- coding: utf-8 -*-
# vim: ft=sls

{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import mapdata as  postgres with context %}

{% if grains.os_family == 'Debian' %}
postgresql-replication-package-install-setup-source-list:
  pkgrepo.managed:
    - humanname: PostgreSQL
    - name: {{postgres.pkgrepo.name}}
    - file: {{postgres.pkgrepo.file}}
    - gpgcheck: 1
    - key_url: {{postgres.pkgrepo.key_url}}
    - require_in:
      - pkg: postgresql-replication-package-install-pkg-installed
{% endif %}

  {% if 'pkgdepedencies' in postgres and  postgres.pkgdepedencies is iterable and postgres.pkgdepedencies is not string %}
postgresql-replication-package-install-deps-pkg-installed:
  pkg.installed:
    - names: {{postgres.pkgdepedencies|json}}
  {% endif %}

postgresql-replication-package-install-pkg-installed:
  pkg.installed:
    - name: {{postgres.pkg.name}}
