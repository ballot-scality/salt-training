{% set users = salt['user.list_users']() %}

add vim addon manager:
  pkg.latest:
    - pkgs:
      {%- if grains['os_family'] == 'Debian' %}
      - vim-addon-manager
      - vim
      {%- elif grains['os_family'] == 'RedHat' %}
      - vim-enhanced
      {%- endif %}

{%- for user in users %}
{%- set userinfo = salt['user.info'](user) %}

{%- if userinfo['home'].startswith('/home') %}
create homedirectory for {{ user }}:
  file.directory:
    - name: {{ userinfo['home'] }}

install vimrc for {{ user }}:
  file.managed:
    - name: {{ userinfo['home'] }}/.vimrc
    - source: salt://common/files/.vimrc
    - mode: 644
    - user: {{ user }}
    - group: {{ userinfo['gid'] }}
{%- endif %}
{%- endfor %}

install vimrc root:
  file.managed:
    - name: /root/.vimrc
    - source: salt://common/files/root.vimrc

clone vundle:
  file.directory:
    - name: /root/.vim
    - mode: 700
  pkg.installed:
    - name: git
  git.latest:
    - name: https://github.com/VundleVim/Vundle.vim.git
    - target: /root/.vim/bundle/Vundle.vim
    - require:
      - pkg: clone vundle


