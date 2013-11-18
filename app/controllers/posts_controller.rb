class PostsController < ApplicationController

  respond_to :json, :html

  def index
    @posts = Post.includes(:user).all

    respond_with @posts do |format|
      format.json { render :json => @posts.to_json(:include => :user) }
    end
  end
end
