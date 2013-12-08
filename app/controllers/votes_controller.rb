class VotesController < ApplicationController
  before_filter :require_user, :only => :create

  #
  # Create a vote for the current user, or replace an existing one if the user has already voted
  #
  def create
    if (!params.key? :value) || (!params.key? :post_id)
      return render :status => :bad_request, :text => "Missing required parameter"
    end

    value = params['value'].to_i
    if ![-1, 1].include? value
      return render :status => :bad_request, :text => "Invalid vote value"
    end

    post = Post.find params[:post_id]
    @vote = post.post_votes.find_or_create_by(user_id: session[:userId])
    @vote.value = value
    @vote.save

    render :json => @vote
  end
end
