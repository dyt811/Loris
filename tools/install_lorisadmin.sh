#!/usr/bin/env bash

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

# Create the project subdirectory (originally in the tool/create-project.sh)
# Project variable:
projectPath=../project
for d in data libraries instruments templates tables_sql modules; do
    mkdir -p "$projectPath/${d}"
done

# Make smarty template and set properly permission.
mkdir -p ../smarty/templates_c
chmod 770 ../smarty/templates_c

mkdir -p ../modules/document_repository/user_uploads
mkdir -p ../modules/data_release/user_uploads

# This concludes the abbreviated version fo the original LORS22 /tools/install.sh script up until Line 134
# The rest goes on in the install_sudo.sh script.
