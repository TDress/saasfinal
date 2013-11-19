class PostsController < ApplicationController

  respond_to :json, :html

  def index
    @posts = Post.includes(:user)

    if params.key? :orderBy
      @posts = @posts.order(params[:orderBy] => params.key?(:orderAsc) ? :asc : :desc)
    end

    if params.key? :createdAfter
      @posts.where("created_on > ?", params[:createdAfter])
    end

    if params.key? :keywords and params[:keywords].length > 0
      @posts = @posts.where("title like ?", "%" + params[:keywords] + "%")
    end

    respond_with @posts do |format|
      format.json { render :json => @posts.to_json(:include => :user) }
    end
  end
end
