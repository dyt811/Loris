#!/bin/bash

# This needs to be run AFTER the initial database setup, which happened during the SELENIUM setup stage.
#"Populating database configuration entries for the Imaging Pipeline and LORIS-MRI code and images Path:"

# This is a modified verion of the script shown at https://github.com/aces/Loris-MRI/blob/master/imaging_install.sh#L221
# Since we are running this bash shell script from the local directory, we do not need host information.
echo "Sleeping 60s waiting for MySQL DB Container to be ready."

# Update dataDirBasepath
mysql $LorisMySQLDatabase -hlorismridb -p3306 -u$LorisMySQLUser -p$LorisMySQLUserPassword -A -e "UPDATE Config SET Value='/data/$LORISProjectName/data/' WHERE ConfigID=(SELECT ID FROM ConfigSettings WHERE Name='dataDirBasepath')"

# Update prefix for project.
mysql $LorisMySQLDatabase -hlorismridb -p3306 -u$LorisMySQLUser -p$LorisMySQLUserPassword -A -e "UPDATE Config SET Value='$LORISProjectName' WHERE ConfigID=(SELECT ID FROM ConfigSettings WHERE Name='prefix')"

# Update Maintenance Email
mysql $LorisMySQLDatabase -hlorismridb -p3306 -u$LorisMySQLUser -p$LorisMySQLUserPassword -A -e "UPDATE Config SET Value='$LorisMaintenanceEmail' WHERE ConfigID=(SELECT ID FROM ConfigSettings WHERE Name='mail_user')"

# Updat get_dicom_info from the bin installed. NOTE it MUST be installed at /bin/mri/dicom-archive/get_dicom_info.pl, in the LORIS image.
mysql $LorisMySQLDatabase -hlorismridb -p3306 -u$LorisMySQLUser -p$LorisMySQLUserPassword -A -e "UPDATE Config SET Value='/data/$LORISProjectName/bin/mri/dicom-archive/get_dicom_info.pl' WHERE ConfigID=(SELECT ID FROM ConfigSettings WHERE Name='get_dicom_info')"

# Update the tarchivel library
mysql $LorisMySQLDatabase -hlorismridb -p3306 -u$LorisMySQLUser -p$LorisMySQLUserPassword -A -e "UPDATE Config SET Value='/data/$LORISProjectName/data/tarchive/' WHERE ConfigID=(SELECT ID FROM ConfigSettings WHERE Name='tarchiveLibraryDir')"

# MODIFIED to reduce the amount of solidity check.
mysql $LorisMySQLDatabase -hlorismridb -p3306 -u$LorisMySQLUser -p$LorisMySQLUserPassword -A -e "UPDATE Config SET Value='/data/$LORISProjectName/bin/mri/' WHERE ConfigID=(SELECT ID FROM ConfigSettings WHERE Name='MRICodePath')"
