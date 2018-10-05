require_relative 'rails_helper'

# Load the portal config file for the url and login details 
portalconfig = YAML.load(File.read("#{Rails.root}/test/system/TestData/portalconfig.yml"))

### Load the required test data from YML file #####

portal_url = portalconfig['portalconfig']['endpoint']['testurl']						# common test url to change the end point in single place			   
ym_admin_email = portalconfig['portalconfig']['admin_login_credentials']['email']	    # YM admin login email 
ym_admin_password = portalconfig['portalconfig']['admin_login_credentials']['password'] # YM admin login password

pti_admin_email = portalconfig['portalconfig']['pti_admin_user']['email']
pti_admin_password = portalconfig['portalconfig']['pti_admin_user']['password']

pti_user_email = portalconfig['portalconfig']['pti_user']['email']
pti_user_password = portalconfig['portalconfig']['pti_user']['password']

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


describe "The portal should show ", js: true, type: :feature do
	  
	  before :each do
	    # Goto the url of application under test
	    visit portal_url
	    # Maximize the browser
	    page.driver.browser.manage.window.maximize 

	  end

	it "all the modules link for YM Admin User" do

		sign_in(ym_admin_email, ym_admin_password)

		expect(page).to have_link 'Companies'

		p 'Companies module link is available'

		expect(page).to have_link 'Code Explorer'

		p 'Code Explorer module link is available'

		expect(page).to have_link 'TIM Explorer'

		p 'TIM Explorer module link is available'

		expect(page).to have_link 'Blockchain'

		p 'Blockchain module link is available'

		expect(page).to have_link 'Form Submissions'

		p 'Form Submissions module link is available'

		expect(page).to have_link 'My Forms'

		p 'My Forms module link is available'

		expect(page).to have_link 'My Reports'

		p 'My Reports module link is available'

		expect(page).to have_link 'Batches'

		p 'Batches module link is available'

		expect(page).to have_link 'Insights'

		p 'Insights module link is available'		

		expect(page).to have_link 'GTIN Manager'

		p 'GTIN Manager module is available'

		expect(page).to have_link 'PTI'

		p 'PTI module link is available'

		expect(page).to have_link 'Settings'

		p 'Settings module is available'

	end

	it 'only GTIN, TPM, PTI & Settings modules for PTI Admin user' do
		
	 	sign_in(pti_admin_email, pti_admin_password)

		expect(page).to have_link 'GTIN Manager'

		p 'GTIN Manager module link is available'

		expect(page).to have_link 'Trace Page Management'

		p 'Trace Page Management module link is available'

		expect(page).to have_link 'Survey Question Management'

		p 'Survey Question Management module link is available'

		expect(page).to have_link 'PTI'

		p 'PTI module link is available'

		expect(page).to have_link 'Settings'

		p 'Settings module is available'

		expect(page).to have_no_link 'Companies'

		p 'Companies module link is not available'

	end

	it 'the sub-modules of PTI module for PTI Admin user' do
	
	 	sign_in(pti_admin_email, pti_admin_password)

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

	    expect(page).to have_no_link 'Companies'

		p 'Companies module link is not available'

	 end

	 it 'as same as PTI admin user but in PTI module it should not show PTI sub modules for PTI user' do
	
	 	sign_in(pti_user_email, pti_user_password)

		expect(page).to have_link 'GTIN Manager'

		p 'GTIN Manager module link is available'

		expect(page).to have_link 'Trace Page Management'

		p 'Trace Page Management module link is available'

		expect(page).to have_link 'Survey Question Management'

		p 'Survey Question Management module link is available'

		expect(page).to have_link 'PTI'

		p 'PTI module link is available'

		expect(page).to have_link 'Settings'

		p 'Settings module is available'

		expect(page).to have_no_link 'Companies'

		p 'Companies module link is not available'

		page.click_link 'PTI'

		expect(page).to have_no_link 'Label Setup'

		p 'Label Setup module link is not available' 

		expect(page).to have_content 'Please click here to download your PTI application.'

		p 'Link to donwload the pti app is available'

	 end

end