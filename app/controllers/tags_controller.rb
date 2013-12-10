class TagsController < ApplicationController
  before_filter :require_user, :only => :create
  respond_to :json

  #
  # Query tag information
  #
  def index
    if params.key? :post_id
      post = Post.find(params[:post_id].to_i)

      @tags = post.post_tags.select("1 as count, *").order(:tag => :asc)
    else
      @tags = PostTag.group(:tag).select("COUNT(post_id) as count, tag, id").order("count DESC")
    end

    if params.key? :keywords
      @tags = @tags.where("lower(tag) like lower(?)", "%#{params[:keywords]}%")
    end

    respond_with @tags
  end

  #
  # Add a tag to a specific post
  #
  def create

  end
end
