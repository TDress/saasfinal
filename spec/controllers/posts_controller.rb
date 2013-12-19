require "spec_helper"

describe PostsController do
  before :each do
    # Always request JSON since this controller only handles API requests
    request.env["HTTP_ACCEPT"] = 'application/json'
    Post.all.each {|post| post.destroy}
  end

  describe "GET #index" do
    it "should return a list of 25 posts when limit is not specified" do
      create_list(:user_with_posts, 6)

      get :index

      expect(response).to be_success
      expect(JSON.parse(response.body).length).to eq(25)
    end

    it "should return a list of posts of length equal to the length parameter" do
      create_list(:user_with_posts, 2)

      get :index, {limit: 2}

      expect(response).to be_success
      expect(JSON.parse(response.body).length).to eq(2)
    end

    it "should limit requests to a maximum of 25 posts if more than 25 are requested" do
      create_list(:user_with_posts, 6)

      get :index, {limit: 30}

      expect(response).to be_success
      expect(JSON.parse(response.body).length).to eq(25)
    end

    it "should return a list of posts ordered by created_on in ascending order when orderAsc is set" do
      create_list(:user_with_posts, 2)

      get :index, {orderBy: :created_on, orderAsc: true}

      expect(response).to be_success
      posts = JSON.parse(response.body)
      expect(posts.length).to eq(10)

      last_created_on = DateTime.parse posts.shift["created_on"]
      posts.each do |post|
        created_on = DateTime.parse post["created_on"]

        expect(created_on).to be > last_created_on
      end
    end

    it "should return a list of posts ordered by created_on in descending order by default" do
      create_list(:user_with_posts, 2)

      get :index, {}

      expect(response).to be_success

      posts = JSON.parse(response.body)

      expect(posts.length).to eq(10)

      last_created_on = DateTime.parse posts.shift["created_on"]
      posts.each do |post|
        created_on = DateTime.parse post["created_on"]

        expect(created_on).to be < last_created_on
      end
    end
  end

  describe "POST #create" do
    before :each do
      create(:user, id: 0)
    end

    it "should create a post" do
      # Simulate login as user 0
      session[:userId] = 0

      time_before_creation = DateTime.now

      post :create, {
          title: "This is the title",
          content: "Here, have some content too!"
      }

      expect(response).to be_success

      posts = Post.where(user_id: 0)
      expect(posts.length).to eq(1)

      post = posts.first
      expect(post.title).to eq("This is the title")
      expect(post.content).to eq("Here, have some content too!")
      expect(post.created_on).to be > time_before_creation
    end

    it "should return 403 forbidden if user is not authenticated" do
      # Log out
      session.delete :userId

      post :create, {
          title: "This is the title",
          content: "Here, have some content too!"
      }

      expect(response).to_not be_success
      expect(response.status).to eq(403)

      posts = Post.where(user_id: 0)
      expect(posts.length).to eq(0)
    end
  end
end
