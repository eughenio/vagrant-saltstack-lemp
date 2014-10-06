web_pkgs:
  pkg.installed:
    - pkgs:
      - memcached
      - nginx

/etc/nginx/nginx.conf:
  file:
    - managed
    - source: salt://web/nginx.conf
    - user: root
    - group: root

/vagrant/log:
  file.directory:
    - user: vagrant
    - group: vagrant
    - mode: 755

nginx:
  service:
    - running
    - enable: True
    - reload: True
    - watch:
      - file: /etc/nginx/nginx.conf

memcached:
  service:
    - running
    - enable: True
    - reload: True
