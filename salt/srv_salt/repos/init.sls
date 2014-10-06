percona-repo:
  pkgrepo.managed:
    - humanname: Percona Repository
    - name: deb http://repo.percona.com/apt trusty main
    - dist: trusty
    - file: /etc/apt/sources.list.d/percona.list
    - keyid: 1C4CBDCDCD2EFD2A
    - keyserver: keyserver.ubuntu.com
    - require_in:
      - pkg: percona-server-server-5.6

php-ppa:
  pkgrepo.managed:
    - ppa: ondrej/php5-oldstable
