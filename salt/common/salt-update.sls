
{%- set salt_version = salt['pillar.get']('saltstack:version') %}

install specific saltstack minion:
  pkgrepo.managed:
    {%- if grains['os_family'] == 'Debian' %}
    - name: deb http://repo.saltstack.com/apt/ubuntu/{{ grains['osrelease'] }}/amd64/{{ salt_version }} {{ grains['oscodename'] }} main
    - file: /etc/apt/sources.list.d/saltstack.list
    - clean_file: True
    - key_url: http://repo.saltstack.com/apt/ubuntu/{{ grains['osrelease'] }}/amd64/{{ salt_version }}/SALTSTACK-GPG-KEY.pub
    {%- elif grains['os_family'] == 'RedHat' %}
    - name: saltstack
    - baseurl: http://repo.saltstack.com/yum/redhat/{{ grains['osmajorrelease'] }}/{{ grains['osarch'] }}/
    - gpgkey: http://repo.saltstack.com/yum/redhat/{{ grains['osmajorrelease'] }}/{{ grains['osarch'] }}/SALTSTACK-GPG-KEY.pub
    - gpgcheck: 1
    {%- endif %}
    - require_in:
      - pkg: install specific saltstack minion
  pkg.latest:
    - name: salt-minion
    - watch:
      - pkgrepo: install specific saltstack minion
  service.running:
    - name: salt-minion
    - watch:
      - pkg: install specific saltstack minion
