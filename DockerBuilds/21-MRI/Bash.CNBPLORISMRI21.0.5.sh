#!/bin/bash

# This needs to be run AFTER the initial LORIS MRI database setup, which happened during the SELENIUM setup stage.
#"Populating database configuration entries for the Imaging Pipeline and LORIS-MRI code and images Path:"

# This is a modified verion of the script shown at https://github.com/aces/Loris-MRI/blob/master/imaging_install.sh#L221
# Since we are running this bash shell script from the local directory, we do not need host information.
echo "Sleeping 60s waiting for MySQL DB Container to be ready."

# Below are LORIS specific configuration


# Update #71. dataDirBasepath
mysql $MySQLDatabase -hlorismridb -p3306 -u$MySQLUser -p$MySQLUserPassword -A -e "UPDATE Config SET Value='/data/$ProjectName/data/' WHERE ConfigID=(SELECT ID FROM ConfigSettings WHERE Name='dataDirBasepath')"

# Update #72 prefix for project.
mysql $MySQLDatabase -hlorismridb -p3306 -u$MySQLUser -p$MySQLUserPassword -A -e "UPDATE Config SET Value='$ProjectName' WHERE ConfigID=(SELECT ID FROM ConfigSettings WHERE Name='prefix')"

# Update #73 Maintenance Email
mysql $MySQLDatabase -hlorismridb -p3306 -u$MySQLUser -p$MySQLUserPassword -A -e "UPDATE Config SET Value='$LorisMaintenanceEmail' WHERE ConfigID=(SELECT ID FROM ConfigSettings WHERE Name='mail_user')"

# Updat #74 get_dicom_info from the bin installed. NOTE it MUST be installed at /bin/mri/dicom-archive/get_dicom_info.pl, in the LORIS image.
mysql $MySQLDatabase -hlorismridb -p3306 -u$MySQLUser -p$MySQLUserPassword -A -e "UPDATE Config SET Value='/data/$ProjectName/bin/mri/dicom-archive/get_dicom_info.pl' WHERE ConfigID=(SELECT ID FROM ConfigSettings WHERE Name='get_dicom_info')"

# Update #78 the tarchivel library
mysql $MySQLDatabase -hlorismridb -p3306 -u$MySQLUser -p$MySQLUserPassword -A -e "UPDATE Config SET Value='/data/$ProjectName/data/tarchive/' WHERE ConfigID=(SELECT ID FROM ConfigSettings WHERE Name='tarchiveLibraryDir')"

# MODIFIED #33 to reduce the amount of solidity check.
mysql $MySQLDatabase -hlorismridb -p3306 -u$MySQLUser -p$MySQLUserPassword -A -e "UPDATE Config SET Value='/data/$ProjectName/bin/mri/' WHERE ConfigID=(SELECT ID FROM ConfigSettings WHERE Name='MRICodePath')"
