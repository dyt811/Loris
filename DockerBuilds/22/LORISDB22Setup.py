from selenium import webdriver
import os
import time
from selenium.webdriver.common.desired_capabilities import DesiredCapabilities

# Note: many env variables are required for this to work. they are normally provided by the DockerFile setup which received them in term from the DockerCompose files.

#load_dotenv(Path("21/.env"))  # 21.0.5 Config
#load_dotenv(Path("21-MRI/.env"))  # 21.0.5-MRI Config


# "loris" here refer to the loris service in the ComposeLORIS21.0.5.yml.
# Make sure not to change this name.
url_configuration ='http://loris:80/installdb.php'

# "hub" here refer to the hub service in the ComposeLORIS21.0.5.yml.
url_hub = "http://hub:4444/wd/hub"


print(url_configuration)
print(url_hub)

# Wait 15 seconds to ensure all services are up and running, especially database.
time.sleep(15)
chrome = webdriver.Remote(url_hub, DesiredCapabilities.CHROME)

# Get the variable from the environment past to us from the DOCKERFILE, which received it from Compose
chrome.get(url_configuration)

# Load the information to fill inside
MySQLHost = os.getenv("MySQLHost")
MySQLRoot = os.getenv("MySQLRoot")
MySQLRootPassword = os.getenv("MySQLRootPassword")

# Set the env based on the value of the arip and port on which hub running arguments
MySQLUser = os.getenv("MySQLUser")
MySQLUserPassword = os.getenv("MySQLUserPassword")
LorisFrontendUser = os.getenv("LorisFrontendUser")
LorisFrontendPassword = os.getenv("LorisFrontendPassword")
MySQLDatabase = os.getenv("MySQLDatabase")

Ext_URL = os.getenv("Ext_URL")
Ext_Port_HTTP = os.getenv("Ext_Port_HTTP")


input_serverhost = chrome.find_element_by_id("serverhost")
input_serverhost.send_keys(MySQLHost)

input_serverhost = chrome.find_element_by_id("serveruser")
input_serverhost.send_keys(MySQLRoot)

input_serverhost = chrome.find_element_by_id("serverpassword")
input_serverhost.send_keys(MySQLRootPassword)

button_submit = chrome.find_element_by_css_selector(".btn-submit")
button_submit.click()
print("First page auto configuration successful.")

# Wait 15 seconds before checking second page to submit.
time.sleep(5)


# Enter LORIS MySQL User Information
input_lorismysqluser = chrome.find_element_by_name("lorismysqluser")
input_lorismysqluser.send_keys(MySQLUser)

# Enter LORIS MySQL User Password Information
input_lorismysqlpassword = chrome.find_element_by_name("lorismysqlpassword")
input_lorismysqlpassword.send_keys(MySQLUserPassword)

# Enter LORIS Frontend User Information
input_frontenduser = chrome.find_element_by_name("frontenduser")
input_frontenduser.send_keys(LorisFrontendUser)

# Enter LORIS Frontend User Password Information
input_frontendpassword = chrome.find_element_by_name("frontendpassword")
input_frontendpassword.send_keys(LorisFrontendPassword)

# Submit the issue for the underlying backend PHP script.
button_submit = chrome.find_element_by_xpath("//input[@type='submit']")
button_submit.click()
print("Second page auto configuration successful.")

# Wait 15 seconds before checking second page to submit.

time.sleep(5)

chrome.quit()
print("Base database configuration finished.")

time.sleep(3)
# Patching up database for the Ext_URL information provided in the .env file.
import sqlalchemy as db
engine = db.create_engine(f'mysql+pymysql://{MySQLUser}:{MySQLUserPassword}@{MySQLHost}/{MySQLDatabase}')
connection = engine.connect()
metadata = db.MetaData()

# the table storing the config settings.
tbl_ConfigSettings = db.Table('ConfigSettings', metadata, autoload=True, autoload_with=engine)

# the table to be updated is the Config table.
tbl_Config = db.Table('Config', metadata, autoload=True, autoload_with=engine)

# Get the ID for the setitng known as "url"
query_url = db.select([tbl_ConfigSettings]).where(tbl_ConfigSettings.columns.Name == "url")
idx_url = connection.execute(query_url).first().ID
# Build query to update URL.
query_update_contrainted = db.update(tbl_Config).values(Value=f"{Ext_URL}:{Ext_Port_HTTP}").where(tbl_Config.columns.ConfigID == idx_url)
# execute
results = connection.execute(query_update_contrainted)
print("SQL update Completed.")

# # Check
# query_45 = db.select([tbl_Config]).where(tbl_Config.columns.ConfigID == 45)
# rp_45 = connection.execute(query_45)
# rs_45 = rp_45.fetchall()
# print(rs_45)

