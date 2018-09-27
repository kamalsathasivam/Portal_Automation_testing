require_relative 'rails_helper'

# Load the portal config file for the url and login details 
portalconfig = YAML.load(File.read("#{Rails.root}/test/system/TestData/portalconfig.yml"))

### Load the required test data from YML file #####

portal_url = portalconfig['endpoint']['testurl']				# common test url to change the end point in single place			   
qa_portal = portalconfig['endpoint']['qa']	                    # QA portal url 
ym_admin_email = portalconfig['admin_login_credentials']['email']	    # YM admin login email 
ym_admin_password = portalconfig['admin_login_credentials']['password'] 	# YM admin login password

pti_admin_email = portalconfig['pti_admin_user']['email']
pti_admin_password = portalconfig['pti_admin_user']['password']

pti_user_email = portalconfig['pti_user']['email']
pti_user_password = portalconfig['pti_user']['password']

	### Test data loaded ###

describe "The portal should show ", js: true, type: :feature do
	  
	  before :each do
	    # Goto the url of application under test
	    visit portal_url
	    # Maximize the browser
	    page.driver.browser.manage.window.maximize 

	  end

	it 'all the modules link for YM Admin User' do

		# Find and fill the email text box
        page.fill_in 'user_email', with: ym_admin_email
        # Find and fill the password text box
		page.fill_in 'user_password', with: ym_admin_password
		# Click on the Sign-In button
		click_on 'sign_in'

		expect(page).to have_link 'Companies', href: 'https://qa.harvestmark.com/companies'

		p 'Companies module link is available'

		expect(page).to have_link 'Code Explorer', href: 'https://qa.harvestmark.com/code_explorer'

		p 'Code Explorer module link is available'

		expect(page).to have_link 'TIM Explorer', href: 'https://qa.harvestmark.com/tracking_codes'

		p 'TIM Explorer module link is available'

		expect(page).to have_link 'Blockchain', href: 'https://qa.harvestmark.com/blockchain'

		p 'Blockchain module link is available'

		expect(page).to have_link 'Form Submissions', href: 'https://qa.harvestmark.com/first_only_events'

		p 'Form Submissions module link is available'

		expect(page).to have_link 'My Forms', href: 'https://qa.harvestmark.com/hf_submission'

		p 'My Forms module link is available'

		expect(page).to have_link 'My Reports', href: 'https://qa.harvestmark.com/reports/display'

		p 'My Reports module link is available'

		expect(page).to have_link 'Batches', href: 'https://qa.harvestmark.com/sauce_to_meat'

		p 'Batches module link is available'

		expect(page).to have_link 'Insights', href: 'https://qa.harvestmark.com/insights/markets'

		p 'Insights module link is available'		

		expect(page).to have_link 'GTIN Manager', href: 'https://qa.harvestmark.com/gtin_records'

		p 'GTIN Manager module is available'

		expect(page).to have_link 'PTI', href: 'https://qa.harvestmark.com/pti_setup'

		p 'PTI module link is available'

		expect(page).to have_link 'Settings', href: 'https://qa.harvestmark.com/settings'

		p 'Settings module is available'

	end

	it 'only GTIN, TPM, PTI & Settings modules for PTI Admin users' do
	
		# Find and fill the email text box
        page.fill_in 'user_email', with: pti_admin_email
        # Find and fill the password text box
		page.fill_in 'user_password', with: pti_admin_password
		# Click on the Sign-In button
		click_on 'sign_in'

		expect(page).to have_link 'GTIN Manager', href: 'https://qa.harvestmark.com/gtin_records'

		p 'GTIN Manager module link is available'

		expect(page).to have_link 'Trace Page Management'

		p 'Trace Page Management module link is available'

		expect(page).to have_link 'Survey Question Management'

		p 'Survey Question Management module link is available'

		expect(page).to have_link 'PTI'

		p 'PTI module link is available'

		expect(page).to have_link 'Settings', href: 'https://qa.harvestmark.com/settings'

		p 'Settings module is available'

	end

	it 'the sub-modules of PTI module for PTI Admin users' do
	
		# Find and fill the email text box
        page.fill_in 'user_email', with: pti_admin_email
        # Find and fill the password text box
		page.fill_in 'user_password', with: pti_admin_password
		# Click on the Sign-In button
		click_on 'sign_in'

		expect(page).to have_link 'PTI'

		p 'PTI module link is available'

		page.click_link 'PTI'

		within(:xpath, '/html/body/div[2]/div/div/div/form/table/thead/tr/th[2]/div' ) do
		expect(page).to have_content('No of Subscription')
		end

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

	it 'as same as PTI admin user but in PTI module it should not show PTI sub modules for PTI users' do
	
		# Find and fill the email text box
        page.fill_in 'user_email', with: pti_user_email
        # Find and fill the password text box
		page.fill_in 'user_password', with: pti_user_password
		# Click on the Sign-In button
		click_on 'sign_in'

		expect(page).to have_link 'GTIN Manager', href: 'https://qa.harvestmark.com/gtin_records'

		p 'GTIN Manager module link is available'

		expect(page).to have_link 'Trace Page Management'

		p 'Trace Page Management module link is available'

		expect(page).to have_link 'Survey Question Management'

		p 'Survey Question Management module link is available'

		expect(page).to have_link 'PTI'

		p 'PTI module link is available'

		expect(page).to have_link 'Settings', href: 'https://qa.harvestmark.com/settings'

		p 'Settings module is available'


	end


end