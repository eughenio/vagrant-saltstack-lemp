percona-server-server-5.6:
  pkg.installed

fix_install_mysql:
  cmd.run:
    - name: "sudo service mysql status; while [ $? -ne 0 ]; do sudo service mysql start; sudo service mysql status; done"

mysql:
  service:
    - running
    - watch:
      - file: /etc/mysql/my.cnf

/etc/mysql/my.cnf:
  file.managed:
    - source: salt://mysql/my.cnf
    - require:
        - pkg: percona-server-server-5.6
