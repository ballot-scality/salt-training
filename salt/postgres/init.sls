{%- if grains['os_family'] == 'RedHat' %}
set epel repository:
  pkg.installed:
    - sources:
      - epel-release: https://dl.fedoraproject.org/pub/epel/epel-release-latest-{{ grains['osmajorrelease'] }}.noarch.rpm
    - require_in:
      - pkg: install postgres
{%- endif %}

install postgres:
  pkgrepo.managed:
    - humanname: Postgresql repository
    {%- if grains['os_family'] == 'Debian' %}
    - key_url: http://www.postgresql.org/media/keys/ACCC4CF8.asc
    - name: deb http://apt.postgresql.org/pub/repos/apt/ {{ grains['oscodename'] }}-pgdg main
    - file: /etc/apt/sources.list.d/postgres.list
    {%- elif grains['os_family'] == 'RedHat' %}
    - name: postgresql95
    - baseurl: http://yum.postgresql.org/9.5/redhat/rhel-{{ grains['osmajorrelease'] }}-{{ grains['osarch'] }}
    - gpgcheck: 1
    - gpgkey: https://ftp.postgresql.org/pub/repos/yum/RPM-GPG-KEY-PGDG-95
    {%- endif %}
    - require_in:
      - pkg: install postgres
  pkg.installed:
    {%- if grains['os_family'] == 'Debian' %}
    - name: postgresql-9.4
    {%- elif grains['os_family'] == 'RedHat' %}
    - pkgs:
      - postgresql95-server
      - postgresql95
    {%- endif %}


start postgres:
  service.running:
    {%- if grains['os_family'] == 'Debian' %}
    - name: postgresql
    {%- elif grains['os_family'] == 'RedHat' %}
    - name: postgresql-9.5
    {%- endif %}
    - enable: True
    - require:
      - pkg: install postgres
  {%- if grains['os_family'] == 'RedHat' %}
  postgres_initdb.present:
    - name: /var/lib/pgsql/9.5/data
    - user: postgres
    - runas: postgres
    - require:
      - pkg: install postgres
  {%- endif %}
