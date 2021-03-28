#!/bin/bash
apt-get update
apt-get install -y postgresql postgresql-contrib
sudo -u postgres psql -c "DROP ROLE IF EXISTS vagrant"
sudo -u postgres psql -c "CREATE ROLE vagrant SUPERUSER LOGIN PASSWORD 'vagrant'"

echo "host    all             all             0.0.0.0/0            md5" >> /etc/postgresql/10/main/pg_hba.conf
echo "listen_addresses = '*'" >> /etc/postgresql/10/main/postgresql.conf
sudo -u postgres dropdb chinook
sudo -u postgres createdb chinook
sudo -u postgres psql -d chinook -f /tmp/chinook_data.sql
systemctl restart postgresql
