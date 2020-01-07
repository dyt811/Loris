from selenium import webdriver
from selenium.webdriver.common.desired_capabilities import DesiredCapabilities
import os
#from dotenv import load_dotenv


PORT = os.getenv("Port_LORIS_HTTP")
LORIS22URL = os.getenv("LORISURL")
url_configuration =f'https://{LORIS22URL}:{PORT}/installdb.php'

#load_dotenv()
chrome = webdriver.Remote(
          command_executor='http://localhost:4444/wd/hub',
          desired_capabilities=DesiredCapabilities.CHROME)
#firefox = webdriver.Remote(
#          command_executor='http://localhost:4444/wd/hub',
#          desired_capabilities=DesiredCapabilities.FIREFOX)

# Get the variable from the environment past to us from the DOCKERFILE, which received it from Compose

chrome.get(url_configuration)

# Load the information to fill inside
LorisMySQLHost = os.getenv("LorisMySQLHost")
LorisMySQLRoot = os.getenv("LorisMySQLRoot")
LorisMySQLRootPassword = os.getenv("LorisMySQLRootPassword")
# Set the env based on the value of the arguments
LorisMySQLUser = os.getenv("LorisMySQLUser")
LorisMySQLUserPassword = os.getenv("LorisMySQLUserPassword")
LorisFrontendUser = os.getenv("LorisFrontendUser")
LorisFrontendPassword = os.getenv("LorisFrontendPassword")


input_serverhost = chrome.find_element_by_id("serverhost")
input_serverhost.send_keys(LorisMySQLHost)

input_serverhost = chrome.find_element_by_id("serveruser")
input_serverhost.send_keys(LorisMySQLRoot)

input_serverhost = chrome.find_element_by_id("serverpassword")
input_serverhost.send_keys(LorisMySQLRootPassword)

button_submit = chrome.find_element_by_css_selector(".btn-submit")
button_submit.click()

# Wait 15 seconds.
import time
time.sleep(15)


input_lorismysqluser = chrome.find_element_by_name("lorismysqluser")
input_lorismysqluser.send_keys(LorisMySQLUser)

input_lorismysqlpassword = chrome.find_element_by_name("lorismysqlpassword")
input_lorismysqlpassword.send_keys(LorisMySQLUserPassword)

input_frontenduser = chrome.find_element_by_name("frontenduser")
input_frontenduser.send_keys(LorisFrontendUser)

input_frontendpassword = chrome.find_element_by_name("frontendpassword")
input_frontendpassword.send_keys(LorisFrontendPassword)

button_submit = chrome.find_element_by_xpath("//input[@type='submit']")
button_submit.click()
chrome.quit()

"""
firefox.get('https://localhost:8080/installdb.php')
print(firefox.title)
firefox.quit()
"""

