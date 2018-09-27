require_relative 'rails_helper'

# Load the portal config file for the url and login details 
portalconfig = YAML.load(File.read("#{Rails.root}/test/system/TestData/portalconfig.yml"))

### Load the required test data from YML file #####

portal_url = portalconfig['endpoint']['testurl']                # common test url to change the end point in single place
qa_portal = portalconfig['endpoint']['qa']                      # QA portal url 
login_email = portalconfig['login_credentials']['email']        # login email 
login_password = portalconfig['login_credentials']['password']  # login password

### Test data loaded ###

## Begin Test ##

describe "The GTIN Module ", js: true, type: :feature do
  
  before :each do
    
    visit portal_url

    page.driver.browser.manage.window.maximize
    
  end

  it 'links are working fine and navigate to the respoective screen', :js => true do

    # Login to the portal
  	page.fill_in 'user_email', with: login_email

	  page.fill_in 'user_password', with: login_password
	
	  click_on 'sign_in'
	
	  puts 'Logged-in successfully'

    # Find and click on the GTIN Manager module link
    click_link 'GTIN Manager'

    # Verify whether we landed into the GTIN manager page or not
  	expect(page).to have_content('GTIN Manager')

    # Select the company 
    page.select 'Sun Pacific', from: 'company'

    sleep 2

    # Find and select the GS1 prefix of the company
    page.select 'Sun Pacific', from: 'gs1_prefix'

    sleep 2

    # Find and click on the GS1 Prefix button
    page.click_link 'Add New GTIN'

    sleep 2

    # Verify whether we landed into the Add new GTIN page or not
    expect(page).to have_content('PRODUCT INFORMATION')

    # Take the screenshot for references
    page.save_screenshot 'SunPacific_GTIN.png'

    puts 'Screenshot taken'

    # Go back to GTIN Manager page
    page.click_link 'Back'

    sleep 2

    # Find and click on the History tab
  	click_link 'History'

    # Verify whether we landed into the GTIN manager history page or not
  	expect(page).to have_content('GTIN History')

  end
end
