require_relative 'rails_helper'

# Load the portal config file for the url and login details 
portalconfig = YAML.load(File.read("#{Rails.root}/test/system/TestData/portalconfig.yml"))

### Load the required test data from YML file #####

portal_url = portalconfig['portalconfig']['endpoint']['testurl']				                  # common test url to change the end point in single place	
login_email = portalconfig['portalconfig']['admin_login_credentials']['email']            # login email 
login_password = portalconfig['portalconfig']['admin_login_credentials']['password']      # login password

     ### Test data loaded ###

## Sign In method 
	def sign_in(email, password) 
	  	# Find and fill the email text box
        page.fill_in 'user_email', with: email
        # Find and fill the password text box
		page.fill_in 'user_password', with: password
		# Click on the Sign-In button
		click_on 'sign_in'
	  end
## sign in method end ##

## Goto GTIN module for adding a new gtin method

	def goto_gtin_module()
	
	# Find and click on the GTIN Manager module link
    click_link 'GTIN Manager'

    # Verify whether we landed into the GTIN manager page or not
  	expect(page).to have_content('GTIN Manager')

    # Select the company 
    page.select 'Riverstone Farms', from: 'company'

    sleep 2

    # Find and select the GS1 prefix of the company
    page.select 'Riverstone', from: 'gs1_prefix'

    sleep 2

    # Find and click on the GS1 Prefix button
    page.click_link 'Add New GTIN'

    sleep 2

    # Verify whether we landed into the Add new GTIN page or not
    expect(page).to have_content('PRODUCT INFORMATION')
	end

## End ###


## Begin Test ##

describe "Portal", js: true, type: :feature do
  
  before :each do
    
      visit portal_url

      page.driver.browser.manage.window.maximize

      sign_in(login_email, login_password)

	  goto_gtin_module()

   end

  it 'should add new gtin if valid data given for all mandatory fields' do

  	# page.check 'gtin_record_ignore_validation'

  	# page.fill_in 'gtin_record_gtin_number' with: ''

  	# Find and select the Commodity 
    page.select 'BANANAS', from: 'gtin_record_commodity_id'

    sleep 5

    # Find and select the Variety 
    page.select 'Red', from: 'gtin_record_variety_id'

    # Enter the descriptiom
    page.fill_in 'gtin_record[description]', with: 'To automate testing'

    # Find and select the Grade 
    page.select 'US #1', from: 'gtin_record[grade_id]'

    # Find and select the Commodity 
    page.select 'Organic', from: 'gtin_record[growing_method_id]'

    # Find and select the Commodity 
    page.select 'Australia', from: 'gtin_record[country_id]'

    # Go back to GTIN Manager page
    page.click_on 'Create GTIN Record'

    sleep 5

    expect(page).to have_content('GTIN record was successfully created in Riverstone GS1 Prefix.')
  end


  it 'should not add new gtin if mandatory fields are not filled' do

  	page.select 'BANANAS', from: 'gtin_record_commodity_id'

    sleep 5

    # Find and select the Variety 
    page.select 'Red', from: 'gtin_record_variety_id'

    # Enter the descriptiom
    #page.fill_in 'gtin_record[description]', with: 'To automate testing'

    # Find and select the Grade 
    page.select 'US #1', from: 'gtin_record[grade_id]'

    # Find and select the Commodity 
    page.select 'Organic', from: 'gtin_record[growing_method_id]'

    # Find and select the Commodity 
    page.select 'Australia', from: 'gtin_record[country_id]'

    # Go back to GTIN Manager page
    page.click_on 'Create GTIN Record'

    sleep 5

    expect(page).to have_content('Please provide a description')
    
  end
end