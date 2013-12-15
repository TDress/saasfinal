class CommentsController < ApplicationController
  before_filter :require_user, :require_param_content, :only => :create
  before_filter :require_param_post_id
  respond_to :json

  #
  # Query comments
  #
  def index
    @comments = PostComment.includes(:user)

    @comments = @comments.where(post_id: params[:post_id])

    respond_with @comments do |format|
      format.json { render :json => @comments.to_json(:include => [:user]) }
    end
  end

  #
  # Add a comment to a specific post
  #
  def create
    post = Post.find(params[:post_id])

    @comment = post.post_comments.new(user_id: session[:userId], content: params[:content], created_on: Time.now)

    if @comment.save
      respond_with @comment do |format|
        format.json { render :json => @comment.to_json(:include => [:user]) }
      end
    else
      respond_with({error: "Failed to save comment."})
    end
  end
end
