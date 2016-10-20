include:
  - postgres

create preprod database:
  postgres_database.present:
    - name: {{ salt['pillar.get']('postgres:database') }}
    - owner: {{ salt['pillar.get']('postgres:owner') }}
    - user: postgres
    - require:
      - postgres_user: create admin preprod database

create admin preprod database:
  postgres_user.present:
    - name: {{ salt['pillar.get']('postgres:owner') }}
    - password: {{ salt['pillar.get']('postgres:password') }}
    - superuser: True

{%- for db_user in salt['pillar.get']('postgres:users') %}
database preprod user {{ db_user['name'] }}:
  postgres_user.present:
    - name: {{ db_user['name'] }}
    - password: {{ db_user['password'] }}
    - user: postgres
    - login: True
    - require:
      - sls: postgres
    - require:
      - postgres_database: create preprod database
{%- endfor %}

