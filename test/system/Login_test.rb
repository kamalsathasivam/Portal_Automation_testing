require_relative 'rails_helper'

# Load the portal config file for the url and login details 
portalconfig = YAML.load(File.read("#{Rails.root}/test/system/TestData/portalconfig.yml"))
portal_url = portalconfig['portalconfig']['endpoint']['testurl']				# common test url to change the end point in single place

#Load the yaml file data 
CONFIG = YAML.load_file("#{Rails.root}/test/system/TestData/LoginTest.yml")
#Assign it to the variable
login_credentials = CONFIG['login_credentials']
#Iterate the data with our test case
login_credentials.each do |k, v|

	describe "The QA portal signin", js: true, type: :feature do
	  
	  before :each do
	    # Goto the url of application under test
	    visit portal_url
	    # Maximize the browser
	    page.driver.browser.manage.window.maximize

	  end

	 it "should #{k}", :js => true do
      	#Assign the vlaues in the variable to iterate 
        email = v['email']
        password = v['password']
        message = v['message']
        
        # Find and fill the email text box
        page.fill_in 'user_email', with: email
        # Find and fill the password text box
		page.fill_in 'user_password', with: password
		# Click on the Sign-In button
		click_on 'sign_in'
		
		# Check whether login pass or not by verifing the url
		if page.current_url == portal_url
			expect(page).to have_content('Sign In')
			page.save_screenshot "#{k}.png"
			puts "Login #{k} entered as expected"
		else
			within(:xpath, '//*[@id="main"]/div/div/div/div/div/h3' ) do
			expect(page).to have_content(message)
			end
		end
	 end

  end

end