require "spec_helper" 
require "pp"

describe UsersController do
  before :each do
    # Always request JSON since this controller only handles API requests
    request.env["HTTP_ACCEPT"] = 'application/json'
    create(:user, id: 0)
  end

  describe "GET #index" do  
	it "should return a single user" do
		get :index, {user_id: 0}
		expect(response).to be_success
	
        user = JSON.parse(response.body)
        # Should be 6 fields in one user object
		expect(user.length).to eq(6)

	end
	
	it "should return the correct name of the user" do
		get :index, {user_id: 0}
		expect(response).to be_success
	
        user = JSON.parse(response.body)
        expect(user["name"]).to eq(User.where(id: 0).take.name)
	end	
  end
end
