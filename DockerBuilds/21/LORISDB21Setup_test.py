from selenium import webdriver
import os
from dotenv import load_dotenv

load_dotenv()
os.environ["LorisMySQLHost"] = "127.0.0.1 -P33306"
#os.environ["LorisMySQLUser"] = "root"
#os.environ["LorisMySQLUserPassword"] = "UltimateSecurePasswordOfCorrectBatteryHorseStaple"

# All the os.env variables automatically will past on to the child proceess.
import subprocess
rc = subprocess.call("./update_database.sh")
