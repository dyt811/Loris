#!/bin/bash

# This needs to be run AFTER the initial LORIS MRI database setup, which happened during the SELENIUM setup stage.
#"Populating database configuration entries for the Imaging Pipeline and LORIS-MRI code and images Path:"

# This is a modified verion of the script shown at https://github.com/aces/Loris-MRI/blob/master/imaging_install.sh#L221
# Since we are running this bash shell script from the local directory, we do not need host information.
echo "Sleeping 60s waiting for MySQL DB Container to be ready."

# Below are CNBP LORIS specific configuration that can be potentially further customized



# Update #2: title
conf_title='Canadian Neonatal Brain Platform'
mysql $MySQLDatabase -hlorismridb -p3306 -u$MySQLUser -p$MySQLUserPassword -A -e "UPDATE Config SET Value='$conf_title' WHERE ConfigID=(SELECT ID FROM ConfigSettings WHERE Name='title')"

# Update #3: study logo
#mysql $MySQLDatabase -hlorismridb -p3306 -u$MySQLUser -p$MySQLUserPassword -A -e "UPDATE Config SET Value='$conf_title' WHERE ConfigID=(SELECT ID FROM ConfigSettings WHERE Name='title')"



# Update #7: min age
conf_ageMin='0'
mysql $MySQLDatabase -hlorismridb -p3306 -u$MySQLUser -p$MySQLUserPassword -A -e "UPDATE Config SET Value='$conf_ageMin' WHERE ConfigID=(SELECT ID FROM ConfigSettings WHERE Name='ageMin')"

# Update #8: max age
conf_ageMax='120'
mysql $MySQLDatabase -hlorismridb -p3306 -u$MySQLUser -p$MySQLUserPassword -A -e "UPDATE Config SET Value='$conf_ageMax' WHERE ConfigID=(SELECT ID FROM ConfigSettings WHERE Name='ageMax')"

# Update #23: imaging auto launch
conf_ImagingUploaderAutoLaunch='1'
mysql $MySQLDatabase -hlorismridb -p3306 -u$MySQLUser -p$MySQLUserPassword -A -e "UPDATE Config SET Value='$conf_ImagingUploaderAutoLaunch' WHERE ConfigID=(SELECT ID FROM ConfigSettings WHERE Name='ImagingUploaderAutoLaunch')"

# Update #26: pwned password check
conf_usePwnedPasswordsAPI='1'
mysql $MySQLDatabase -hlorismridb -p3306 -u$MySQLUser -p$MySQLUserPassword -A -e "UPDATE Config SET Value='$conf_usePwnedPasswordsAPI' WHERE ConfigID=(SELECT ID FROM ConfigSettings WHERE Name='usePwnedPasswordsAPI')"


# Update #28: image path default to /data/loris/data

# Update #42: study description in HTML
conf_StudyDescription='<p>This Loris instance is designed for the Canadian Neonatal Brain Platform, visit us at cnbp.ca if you would like to learn more.</p>'
mysql $MySQLDatabase -hlorismridb -p3306 -u$MySQLUser -p$MySQLUserPassword -A -e "UPDATE Config SET Value='$conf_StudyDescription' WHERE ConfigID=(SELECT ID FROM ConfigSettings WHERE Name='StudyDescription')"

# Update #44: host?
#conf_host='localhost'
#mysql $MySQLDatabase -hlorismridb -p3306 -u$MySQLUser -p$MySQLUserPassword -A -e "UPDATE Config SET Value='$conf_host' WHERE ConfigID=(SELECT ID FROM ConfigSettings WHERE Name='host')"


# Update #45: url of the main loris?
conf_url='localhost'
mysql $MySQLDatabase -hlorismridb -p3306 -u$MySQLUser -p$MySQLUserPassword -A -e "UPDATE Config SET Value='$conf_url' WHERE ConfigID=(SELECT ID FROM ConfigSettings WHERE Name='url')"

# Update #48: project description




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

echo "Basic LORIS MRI 21.0.5 database update with CNBP customizaiton is now complete. "
