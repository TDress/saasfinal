class PostsController < ApplicationController
  before_filter :require_user, :only => :create
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
    @posts = Post.includes(:user).includes(:post_votes)

    if params.key? :orderBy
      @posts = @posts.order(params[:orderBy] => params.key?(:orderAsc) ? :asc : :desc)
    end

    if params.key? :createdAfter
      time = Time.at(params[:createdAfter].to_i)
      @posts = @posts.where("created_on > ?", time)
    end

    if params.key? :keywords and params[:keywords].length > 0
      @posts = @posts.where("lower(title) like lower(?)", "%" + params[:keywords] + "%")
    end

    if params.key? :sortUserPostsBy
      @posts = @posts.where(user_id: params[:user_id])

      if params[:sortUserPostsBy]=='top'
        @posts = @posts.order('created_on' => params.key?(:orderAsc) ? :desc : :asc)
      else
        @posts = @posts.order('created_on' => params.key?(:orderAsc) ? :asc : :desc)
      end
    end

    if params.key? :userId
      @posts = @posts.where(user_id: params[:userId])
    end

    if params.key? :limit
      @posts = @posts.limit(params[:limit].to_i)
    end

    if params.key? :offset
      @posts = @posts.offset(params[:offset].to_i)
    end

    respond_with @posts do |format|
      format.json { render :json => @posts.to_json(:include => [:user, :post_votes]) }
    end
  end

  def create
	@flashnotice = {}
	@post = Post.new(:title=> params["title"], :content=> params["content"],
					:created_on=> Time.now, :user_id=> session[:userId])
	if @post.save
		@flashnotice[:success] = "Post was successfully created."
		respond_with @flashnotice do |format|
			format.json { render :json=>@flashnotice.to_json }
		end
	else
		@flashnotice[:error] = "An error occurred.  Please try again later."
		respond_with @flashnotice do |format|
			format.json { render :json=>@flashnotice.to_json }
		end
	end
  end
end




