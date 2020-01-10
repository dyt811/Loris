#!/bin/bash

# This needs to be run AFTER the initial database setup, which happened during the SELENIUM setup stage.
#"Populating database configuration entries for the Imaging Pipeline and LORIS-MRI code and images Path:"
mysql $LorisMySQLDatabase -h$LorisMySQLHost -u$LorisMySQLUser -p$LorisMySQLUserPassword -A -e "UPDATE Config SET Value='/data/$LORISProjectName/data/' WHERE ConfigID=(SELECT ID FROM ConfigSettings WHERE Name='dataDirBasepath')"
mysql $LorisMySQLDatabase -h$LorisMySQLHost -u$LorisMySQLUser -p$LorisMySQLUserPassword -A -e "UPDATE Config SET Value='$LORISProjectName' WHERE ConfigID=(SELECT ID FROM ConfigSettings WHERE Name='prefix')"
mysql $LorisMySQLDatabase -h$LorisMySQLHost -u$LorisMySQLUser -p$LorisMySQLUserPassword -A -e "UPDATE Config SET Value='$LorisMaintenanceEmail' WHERE ConfigID=(SELECT ID FROM ConfigSettings WHERE Name='mail_user')"
mysql $LorisMySQLDatabase -h$LorisMySQLHost -u$LorisMySQLUser -p$LorisMySQLUserPassword -A -e "UPDATE Config SET Value='/data/$LORISProjectName/bin/mri/dicom-archive/get_dicom_info.pl' WHERE ConfigID=(SELECT ID FROM ConfigSettings WHERE Name='get_dicom_info')"
mysql $LorisMySQLDatabase -h$LorisMySQLHost -u$LorisMySQLUser -p$LorisMySQLUserPassword -A -e "UPDATE Config SET Value='/data/$LORISProjectName/data/tarchive/' WHERE ConfigID=(SELECT ID FROM ConfigSettings WHERE Name='tarchiveLibraryDir')"
mysql $LorisMySQLDatabase -h$LorisMySQLHost -u$LorisMySQLUser -p$LorisMySQLUserPassword -A -e "UPDATE Config SET Value='/data/$LORISProjectName/bin/mri/' WHERE ConfigID=(SELECT ID FROM ConfigSettings WHERE Name='MRICodePath') AND Value = '/data/$LORISProjectName/bin/mri/'"
