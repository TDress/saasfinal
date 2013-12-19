require "spec_helper"

describe CommentsController do
  before :each do
    # Always request JSON since this controller only handles API requests
    request.env["HTTP_ACCEPT"] = 'application/json'
  end

  describe "GET #index" do
    it "should return a list of comments" do
      create(:post_with_comments, id: 1234)

      get :index, {
          post_id: 1234
      }

      expect(response).to be_success
      expect(JSON.parse(response.body).length).to eq(2)
    end
  end

  describe "POST #create" do
    before :each do
      create(:user, id: 0)
    end

    it "should create a comment" do
      # Simulate login as user 0
      session[:userId] = 0

      time_before_creation = DateTime.now
      create(:post, id: 1234)

      post :create, {
          post_id: 1234,
          content: "Here, have some comments!"
      }

      expect(response).to be_success

      comments = Post.find(1234).post_comments
      expect(comments.length).to eq(1)

      comment = comments.first
      expect(comment.content).to eq("Here, have some comments!")
      expect(comment.created_on).to be > time_before_creation
    end

    it "should return 403 forbidden if user is not authenticated" do
      # Log out
      session.delete :userId

      post :create, {
          post_id: 1234,
          content: "This isn't going to work!"
      }

      expect(response).to_not be_success
      expect(response.status).to eq(403)

      comments = PostComment.where(user_id: 0)
      expect(comments.length).to eq(0)
    end
  end
end
