base:
  '*':
    - default
  'os_family:Debian':
    - preprod
    - match: grain
  'os_family:RedHat':
    - prod
    - match: grain
