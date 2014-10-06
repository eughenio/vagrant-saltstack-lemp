/swapfile:
  cmd.run:
    - name: "fallocate -l 1024M /swapfile && chmod 600 /swapfile && mkswap /swapfile"
    - unless: test -f /swapfile
  mount.swap:
    - require:
      - cmd: /swapfile

mypkgs:
  pkg.installed:
    - pkgs:
      - curl
      - git-core
      - screen
      - vim
      - telnet
      - lsof
      - strace
      - patch
      - htop
      - sysv-rc-conf
      - mytop

set_locale:
  cmd.run:
    - name: "locale-gen pt_BR pt_BR.UTF-8 && dpkg-reconfigure locales"

America/Sao_Paulo:
  timezone.system

/root/.screenrc:
  file:
    - managed
    - source: salt://base/screenrc
    - user: root
    - group: root

iptables:
  service:
    - dead
    - enable: False

ip6tables:
  service:
    - dead
    - enable: False
