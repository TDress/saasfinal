require "spec_helper"

require "pp"

describe PostsController do
  before :each do
    #expect(@controller).to receive(:require_user)
    request.env["HTTP_ACCEPT"] = 'application/json'
  end

  describe "GET #index" do
    it "should return a list of 25 posts when limit is not specified" do
      create_list(:user_with_posts, 6)

      get :index

      expect(response).to be_success

      expect(JSON.parse(response.body).length).to eq(25)
    end

    it "should return a list of posts of length equal to the length parameter" do
      create_list(:user_with_posts, 6)

      get :index, {limit: 2}
      pp request
      expect(response).to be_success

      expect(JSON.parse(response.body).length).to eq(2)
    end

    it "should return a list of posts ordered by created_on" do
      create_list(:user_with_posts, 2)

      get :index, {orderBy: :created_on, orderAsc: true}

      expect(response).to be_success

      posts = JSON.parse(response.body)

      expect(posts.length).to eq(10)

      last_created_on = DateTime.new 0
      posts.each do |post|
        created_on = DateTime.parse post["created_on"]

        expect(created_on).to be > last_created_on
      end
    end

  end
end
