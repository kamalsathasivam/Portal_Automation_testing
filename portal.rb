require 'selenium-webdriver'
require 'yaml'

#portalconfig = YAML.load(File.read('/Users/sjacob/Development/portal_automation/portalconfig.yml'))
portalconfig = YAML.load(File.read('portalconfig.yml'))
portaldata = YAML.load(File.read('portaldata.yml'))

puts portalconfig
puts portaldata

firefox_browser = portalconfig['browser']['firefox']
chrome_browser = portalconfig['browser']['chrome']
safari_browser = portalconfig['browser']['safari']

puts firefox_browser
puts chrome_browser
puts safari_browser

username = portaldata['users']['admin']
password = portaldata['users']['adminpwd']

ror_qa = portalconfig['endpoint']['qa']
ror_stage = portalconfig['endpoint']['stage']
ror_prod = portalconfig['endpoint']['prod']

driver = Selenium::WebDriver.for :chrome
#driver = Selenium::WebDriver.for :firefox
#driver = Selenium::WebDriver.for :safari

driver.manage.timeouts.implicit_wait = 10
driver.manage.window.maximize

#driver.get "https://qa.harvestmark.com/users/sign_in"

driver.get ror_qa
#driver.get ror_stage
#driver.get ror_prod

username_txt = driver.find_element(:id, 'user_email')
username_txt.send_keys(username)

password_txt = driver.find_element(:id, 'user_password')
password_txt.send_keys(password)

login_button = driver.find_element(:id, 'sign_in')
login_button.click

wait =  Selenium::WebDriver::Wait.new(:timeout =>10)
wait.until {driver.find_element(:link_text, 'Insights')}.click

puts 'Checking all the Insights Links'

driver.find_element(:link_text, 'Markets').click
puts 'Clicked on Markets'

driver.find_element(:link_text, 'Ratings').click
puts 'Clicked on Ratings'

driver.find_element(:link_text, 'Containers').click
puts 'Clicked on Containers'

driver.find_element(:link_text, 'Devices').click
puts 'Clicked on Devices'

driver.find_element(:link_text, 'Programs').click
puts 'Clicked on Programs'

driver.find_element(:link_text, 'Specifications').click
puts 'Clicked on Specifications'

driver.find_element(:link_text, 'Insights Products').click
puts 'Clicked on Insights Products'

driver.find_element(:link_text, 'Locations').click
puts 'Clicked on Locations'

driver.find_element(:link_text, 'DC Inspection').click
puts 'Clicked on DC Inspections'

driver.find_element(:link_text, 'Uploads').click
puts 'Clicked on Uploads'

driver.find_element(:link_text, 'Watched Products').click
puts 'Clicked on Watched Products'

driver.find_element(:link_text, 'Edit Inspections').click
puts 'Clicked on Edit Inspections'

driver.find_element(:link_text, 'Supplier Contacts').click
puts 'Clicked on Supplier Contacts'

driver.find_element(:link_text, 'Inspection Minimums').click
puts 'Clicked on Inspection Minimums'

driver.find_element(:link_text, 'Notification Template Manager').click
puts 'Clicked on Notification Template Manager'


puts 'Checked All the Insights Links'
#puts driver.title

driver.quit


#username = driver.find_element(:name, "user[email]")
#$username.send_keys("dev@yottamark.com")
#password = driver.find_element(:name, "user[password]")
#password.send_keys(password_data)
#puts Dir.pwd + " This is the current Directory"