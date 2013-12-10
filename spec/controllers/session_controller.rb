require "spec_helper"
require "pp"
describe SessionController do
  before :each do
     # Use a fake XSRF token that we can test against
    request.cookies[:"XSRF-TOKEN"] = "1234567890-0987654321"
  end

  describe "GET #create" do
    it "should redirect to a valid LinkedIn login URL" do
      expect(LinkedIn).to receive(:auth_url)
                          .with("http://test.host/session/oauth2", request.cookies[:"XSRF-TOKEN"])
                          .and_return("http://fake-redirect-url.com/")

      get :create

      expect(response).to be_redirect
      expect(response).to redirect_to("http://fake-redirect-url.com/")
    end
  end

  describe "GET #oauth2_callback" do
    it "should validate that state is received" do
      get :oauth2_callback, {state: "bogus"}

      expect(response).to_not be_success
      expect(response.status).to eq(403)
      expect(assigns(:result)).to match(/XSRF Token Mismatch/)
    end

    it "should check the error message parameter from LinkedIn" do
      get :oauth2_callback, {state: request.cookies[:"XSRF-TOKEN"], error: "Epic Failure"}

      expect(response).to_not be_success
      expect(response.status).to eq(403)
      expect(assigns(:result)).to match(/Epic Failure/)
    end

    it "should exchange the auth code for an access token and create a user with the LinkedIn profile data" do
      fake_code = "123abc"
      fake_linkedin_id = "123abc987xyz"
      fake_url = "http://fake-url.fake/"

      fake_user = LinkedIn::LinkedInUser.new(fake_code)
      fake_user.instance_variable_set(:@profile, {
          'first-name' => 'First',
          'last-name' => 'Last',
          'email-address' => 'email@internet.com',
          'id' => fake_linkedin_id,
          'public-profile-url' => fake_url
      })

      expect(LinkedIn).to receive(:access_token)
                          .with(fake_code, "http://test.host/session/oauth2")
                          .and_return(fake_user)

      expect(User.find_by_linkedin_id(fake_linkedin_id)).to be_nil

      get :oauth2_callback, {state: request.cookies[:"XSRF-TOKEN"], code: fake_code}

      user = User.find_by_linkedin_id(fake_linkedin_id)

      expect(user).to_not be_nil
      expect(user.name).to eq("First Last")
      expect(user.linkedin_url).to eq(fake_url)

      expect(response).to be_success
      expect(assigns(:event)).to eq("loginSuccess")
    end

    it "should not create a new user if they already exist in the database" do
      fake_code = "123abc"
      fake_linkedin_id = "123abc987xyz"
      fake_user = LinkedIn::LinkedInUser.new(fake_code)
      fake_user.instance_variable_set(:@profile, {'id' => fake_linkedin_id})

      expect(LinkedIn).to receive(:access_token).and_return(fake_user)
      expect(User).to_not receive(:create)

      create(:user, linkedin_id: fake_linkedin_id)

      get :oauth2_callback, {state: request.cookies[:"XSRF-TOKEN"], code: fake_code}

      expect(response).to be_success
      expect(assigns(:event)).to eq("loginSuccess")
    end

  end
end
