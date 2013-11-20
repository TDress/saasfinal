class PostsController < ApplicationController

  respond_to :json, :html

  #
  # Query posts, optionally including search criteria
  #
  # ===== Parameters
  # * +orderBy+ - Column or field name to sort results by.
  # * +orderAsc+ - If included, results are sorted in ascending order, otherwise descending order is used.
  # * +createdAfter+ - Return posts created after this time. Specified in seconds since the epoch.
  # * +keywords+ - String of search keywords
  #
  def index
    @posts = Post.includes(:user)

    if params.key? :orderBy
      @posts = @posts.order(params[:orderBy] => params.key?(:orderAsc) ? :asc : :desc)
    end

    if params.key? :createdAfter
      time = Time.at(params[:createdAfter].to_i)
      @posts = @posts.where("created_on > ?", time)
    end

    if params.key? :keywords and params[:keywords].length > 0
      @posts = @posts.where("title like ?", "%" + params[:keywords] + "%")
    end

    respond_with @posts do |format|
      format.json { render :json => @posts.to_json(:include => :user) }
    end
  end
end
