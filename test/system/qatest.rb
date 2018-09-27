require 'selenium-webdriver'
require 'rspec'
require 'test/unit/assertions'

include Test::Unit::Assertions

 Selenium::WebDriver::Chrome.driver_path="/home/rajkamal/Downloads/Drivers/chromedriver"

 driver = Selenium::WebDriver.for :chrome

 driver.manage.timeouts.implicit_wait = 10
 driver.manage.window.maximize

 driver.get 'https://qa.harvestmark.com'

 puts 'QA site launched successfully'

 username_txt = driver.find_element(:id, 'user_email')
 username_txt.send_keys('dev@yottamark.com')

 password_txt = driver.find_element(:id, 'user_password')
 password_txt.send_keys('bbb123')

 login_button = driver.find_element(:id, 'sign_in')
 login_button.click

 sleep 5

 LoggedUser = driver.find_element(:xpath, '//*[@id="main"]/div/div/div/div/div/h3').text

 assert_equal(LoggedUser, 'Welcome, Ryan.')

 puts 'Successfully lgged-in as admin user (Ryan)'


