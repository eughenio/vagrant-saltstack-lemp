php5-stuff:
  pkg.installed:
    - pkgs:
      - php5-fpm
      - php5-mcrypt
      - php5-mysql
      - php5-cli
      - php5-json
      - php5-xdebug
      
php5enmod:
  cmd.run:
    - name: sudo php5enmod mcrypt

/etc/php5/fpm/pool.d/www.conf:
  file:
    - managed
    - source: salt://php/www.conf
    - user: root
    - group: root

/etc/php5/mods-available/xdebug.ini:
  file.managed:
    - source: salt://php/xdebug.ini

/etc/php5/fpm/php.ini:
  file.managed:
    - source: salt://php/php.ini

/etc/php5/cli/php.ini:
  file.managed:
    - source: salt://php/php.ini

/var/lib/php5/session:
  file.directory:
    - user: vagrant
    - group: vagrant
    - mode: 755

/usr/local/bin/xdebug:
  file.managed:
    - source: salt://php/xdebug.sh
    - mode: 755
    
php5-fpm:
  service:
    - running
    - enable: true
    - reload: true
    - require:
      - php5enmod
    - watch:
      - file: /etc/php5/mods-available/xdebug.ini
      - file: /etc/php5/fpm/php.ini
      - file: /etc/php5/cli/php.ini
      - file: /etc/php5/fpm/pool.d/www.conf

get-composer:
  cmd.run:
    - name: 'CURL=`which curl`; $CURL -sS https://getcomposer.org/installer | php'
    - unless: test -f /usr/local/bin/composer
    - cwd: /root/

install-composer:
  cmd.wait:
    - name: mv /root/composer.phar /usr/local/bin/composer
    - cwd: /root/
    - watch:
      - cmd: get-composer
