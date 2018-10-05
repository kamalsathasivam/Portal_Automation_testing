require_relative 'rails_helper'

# Load the portal config file for the url and login details 
portalconfig = YAML.load(File.read("#{Rails.root}/test/system/TestData/portalconfig.yml"))

### Load the required test data from YML file #####

portal_url = portalconfig['portalconfig']['endpoint']['testurl']				                  # common test url to change the end point in single place	
login_email = portalconfig['portalconfig']['admin_login_credentials']['email']            # login email 
login_password = portalconfig['portalconfig']['admin_login_credentials']['password']      # login password

     ### Test data loaded ###

## Begin Test ##

describe "Test whether PTI and its", js: true, type: :feature do
  
  before :each do
    
      visit portal_url

      page.driver.browser.manage.window.maximize

      # Login to the portal
    	page.fill_in 'user_email', with: login_email

  	  page.fill_in 'user_password', with: login_password
  	
  	  click_on 'sign_in'
  	
  	  puts 'Logged-in successfully'

      # Find and click on the PTI module link
      click_link 'PTI'
    
  end

  it 'all sub-module links are navigates to the respective screen' do

    # Click on the sub-modules and check.

	# Select the company 
	page.select 'Sun Pacific', from: 'company'

	sleep 2

    # page.click_button 'Show Subscriptions'
	within(:xpath, '/html/body/div[2]/div/div/div/form/table/thead/tr/th[2]/div' ) do
		expect(page).to have_content('No of Subscription')
	end

    p 'PTI Setup Module verified'

    # Label setup module
    page.click_link 'Label Setup'

    # Check whether we have landed into the list subscription page
    expect(page).to have_content('Select Label:')
    p 'Label Setup module verified'

    # Reports module
    page.click_link 'Reports'
    # Check whether we have landed into the list subscription page
    expect(page).to have_content('Reports')
    p 'Reports module verified'

    # Settings module
    find('ul.nav-pills:nth-child(1) > li:nth-child(4) > a:nth-child(1)', match: :prefer_exact).click

 	# Check whether we have landed into the list subscription page
    expect(page).to have_content('No of days PTI user can work offline')
    p 'Settings module verified'

    p 'All PTI sub-modules are clicked and verified'

  end

end