#!/bin/bash

set -e

sed -i "s|MRG_PSWD|$MRG_PSWD|" /var/www/morgue/schemas/create_db.sql
sed -i "s|SRV_NAME|$HOSTNAME|" /etc/apache2/sites-available/000-default.conf
sed -i "s|localhost|$DB_HOST|" /var/www/morgue/config/development.json
sed -i "s|morgue_password|$MRG_PSWD|" /var/www/morgue/config/development.json
sed -i "s|Europe/Zurich|$TZ|" /var/www/morgue/config/development.json

mysql -u root -p -h $DB_HOST --password=$DB_PSWD < /var/www/morgue/schemas/create_db.sql
mysql -u morgue -p -h $DB_HOST --password=$MRG_PSWD morgue < /var/www/morgue/schemas/postmortems.sql
mysql -u morgue -p -h $DB_HOST --password=$MRG_PSWD morgue < /var/www/morgue/schemas/images.sql
mysql -u morgue -p -h $DB_HOST --password=$MRG_PSWD morgue < /var/www/morgue/schemas/jira.sql
mysql -u morgue -p -h $DB_HOST --password=$MRG_PSWD morgue < /var/www/morgue/schemas/links.sql
mysql -u morgue -p -h $DB_HOST --password=$MRG_PSWD morgue < /var/www/morgue/schemas/irc.sql
mysql -u morgue -p -h $DB_HOST --password=$MRG_PSWD morgue < /var/www/morgue/schemas/anniversary.sql
mysql -u morgue -p -h $DB_HOST --password=$MRG_PSWD morgue < /var/www/morgue/schemas/slack.sql

exec "$@"