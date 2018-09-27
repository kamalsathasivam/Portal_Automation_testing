require 'selenium-webdriver'
require 'yaml'

puts 'locading configs'

portalconfig = YAML.load(File.read('portalconfig.yaml'))
portaldata = YAML.load(File.read('portaldata.yaml'))

puts portalconfig
puts portaldata


firefox_browser = portalconfig['browser']['firefox']
chrome_browser = portalconfig['browser']['chrome']
safari_browser = portalconfig['browser']['safari']

puts firefox_browser
puts chrome_browser
puts safari_browser


puts 'configs loaded'

driver = Selenium::WebDriver.for :chrome
#driver = Selenium::WebDriver.for :firefox
#driver = Selenium::WebDriver.for :safari

driver.manage.timeouts.implicit_wait = 10

driver.manage.window.maximize
driver.get "https://qa.harvestmark.com/users/sign_in"


#username = driver.find_element(:name, "user[email]")
username = driver.find_element(:xpath, ".//*[@id='user_email']")
username.send_keys("dev@yottamark.com")
#username.send_keys(user_name)

#password = driver.find_element(:name, "user[password]")
password = driver.find_element(:xpath, ".//*[@id='user_password']")
password.send_keys("bbb123")
#password.send_keys(password_data)


#login_button = driver.find_element(:name, "button")
login_button = driver.find_element(:xpath, ".//*[@id='sign_in']")
login_button.click

wait =  Selenium::WebDriver::Wait.new(:timeout =>5)
wait.until {driver.find_element(:link_text, 'Companies')}

puts 'Waited for Driver'

puts driver.title

driver.quit






