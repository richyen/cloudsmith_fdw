#!/bin/bash

service postgresql start
cd /cloudsmith_fdw && python3 setup.py install
sed "s/your_secret_api_key/${CLOUDSMITH_TOKEN}/" /cloudsmith_fdw/sample_sql/packages.sample.sql | psql postgres postgres
psql -c "SELECT * FROM cloudsmith.packages LIMIT 10" postgres postgres

# Keep things running
touch /var/log/messages && tail -f /var/log/messages
