include:
  - postgres

create prod database:
  postgres_database.present:
    - name: {{ salt['pillar.get']('postgres:database') }}
    - owner: {{ salt['pillar.get']('postgres:owner') }}
    - user: postgres
    - require:
      - postgres_user: create admin prod database

create admin prod database:
  postgres_user.present:
    - name: {{ salt['pillar.get']('postgres:owner') }}
    - password: {{ salt['pillar.get']('postgres:password') }}
    - superuser: True

{%- for db_user in salt['pillar.get']('postgres:users') %}
database prod user {{ db_user['name'] }}:
  postgres_user.present:
    - name: {{ db_user['name'] }}
    - password: {{ db_user['password'] }}
    - user: postgres
    - login: True
    - require:
      - sls: postgres
    - require:
      - postgres_database: create prod database
{%- endfor %}

