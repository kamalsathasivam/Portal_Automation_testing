require 'selenium-webdriver'

Selenium::WebDriver::Chrome.driver_path="/Home/Downloads/chromedriver"

driver = Selenium::WebDriver.for :Chrome

driver.manage.timeouts.implicit_wait = 10
driver.manage.window.maximize

driver.get 'https://qa.harvestmark.com'

puts 'QA site launched successfully'