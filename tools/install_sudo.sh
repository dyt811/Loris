#!/usr/bin/env bash

# $1 is the projectname based past on from the main script.

chown www-data.www-data ../modules/document_repository/user_uploads
chown www-data.www-data ../modules/data_release/user_uploads
chown www-data.www-data ../smarty/templates_c
# Make Apache the group for project directory, so that the web based install
# can write the config.xml file.
chgrp www-data ../project
chmod 770 ../project

# Set the proper permission for the tools/logs directory:
chmod 770 logs

# Set the group to 'www-data' or 'apache' for tools/logs directory:
chgrp www-data logs

echo "Ubuntu distribution detected."


CWD=`pwd`
RootDir=`dirname $CWD`
logdirectory=/var/log/apache2
# Configuring Apache Configuration.
export projectname=$1

# Need to pipe to sudo tee because > is done as the logged in user, even if run through sudo
sed -e "s#%LORISROOT%#$RootDir#g" \
    -e "s#%PROJECTNAME%#$projectname#g" \
    -e "s#%LOGDIRECTORY%#$logdirectory#g" \
    < ../docs/config/apache2-site | tee /etc/apache2/sites-available/$projectname.conf > /dev/null
ln -s /etc/apache2/sites-available/$projectname.conf /etc/apache2/sites-enabled/$projectname.conf
a2dissite 000-default
a2ensite $projectname.conf
a2enmod rewrite
a2enmod headers


echo "Script execution finished. Installation of LORIS directory structure is complete."
echo "Please keep a copy of this script output for troubleshooting purposes. "
echo ""
echo "Next steps: "
echo "- Run 'make' (or 'make dev') from inside your $RootDir folder."
echo "- Verify/enable your apache configuration and restart apache"
echo "- Navigate to <loris-url>/installdb.php using a supported browser (Chrome or Firefox) to continue installing the database."
