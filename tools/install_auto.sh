#!/usr/bin/env bash

#
# This script will:
#   1. Install the directory structure with appropriate permissions
#   2. Configure apache (optional)
#   3. Log these steps in the logs/ directory (if writable)
#

# Ensure execution does not cause problem.
set -euo pipefail

# Create logs directory, if needed.
mkdir -p logs

START=`date "+%Y-%m-%dT%H:%M:%S"`
LOGDIR="logs"
LOGFILE="logs/install-$START.log"
LOGPIPE=/tmp/pipe.$$
mkfifo -m 700 $LOGPIPE
trap "rm -f $LOGPIPE" EXIT
tee -a <$LOGPIPE $LOGFILE &
exec 1>$LOGPIPE 2>&1

CWD=`pwd`
RootDir=`dirname $CWD`

echo "LORIS Installation Script starting at $START"

# Create the project subdirectory
./create-project.sh ../project

# Make smarty template and set properly permission.
mkdir -p ../smarty/templates_c
chmod 770 ../smarty/templates_c

# Get the OS_distro variable, which is Ubuntu in this case.
os_distro=$(hostnamectl |awk -F: '/Operating System:/{print $2}'|cut -f2 -d ' ')


debian=("Debian" "Ubuntu")
redhat=("Red" "CentOS" "Fedora" "Oracle")


mkdir -p ../modules/document_repository/user_uploads
mkdir -p ../modules/data_release/user_uploads
sudo chown www-data.www-data ../modules/document_repository/user_uploads
sudo chown www-data.www-data ../modules/data_release/user_uploads
sudo chown www-data.www-data ../smarty/templates_c
# Make Apache the group for project directory, so that the web based install
# can write the config.xml file.
sudo chgrp www-data ../project
sudo chmod 770 ../project

# Set the proper permission for the tools/logs directory:
chmod 770 logs

# Set the group to 'www-data' or 'apache' for tools/logs directory:
sudo chgrp www-data logs

echo "Ubuntu distribution detected."

logdirectory=/var/log/apache2

# Configuring Apache Configuration.
export projectname="DeployedLORISProject"

# Need to pipe to sudo tee because > is done as the logged in user, even if run through sudo
sed -e "s#%LORISROOT%#$RootDir#g" \
    -e "s#%PROJECTNAME%#$projectname#g" \
    -e "s#%LOGDIRECTORY%#$logdirectory#g" \
    < ../docs/config/apache2-site | sudo tee /etc/apache2/sites-available/$projectname.conf > /dev/null
sudo ln -s /etc/apache2/sites-available/$projectname.conf /etc/apache2/sites-enabled/$projectname.conf
sudo a2dissite 000-default
sudo a2ensite $projectname.conf
sudo a2enmod rewrite
sudo a2enmod headers
break;;


echo "Script execution finished. Installation of LORIS directory structure is complete."
echo "Please keep a copy of this script output for troubleshooting purposes. "
echo ""
echo "Next steps: "
echo "- Run 'make' (or 'make dev') from inside your $RootDir folder."
echo "- Verify/enable your apache configuration and restart apache"
echo "- Navigate to <loris-url>/installdb.php using a supported browser (Chrome or Firefox) to continue installing the database."
