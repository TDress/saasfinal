class TagsController < ApplicationController
  before_filter :require_user, :require_param_post_id, :require_param_tag, :only => :create

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

    render json: @tags
  end

  #
  # Add a tag to a specific post
  #
  def create
    post = Post.find(params[:post_id]).post_tags

    @tag = post.new({tag: params[:tag]})

    if @tag.save
      render json: @tag
    else
      render json: {error: "Failed to save tag."}
    end
  end
end
