class UsersController < ApplicationController
	respond_to :json, :html

	def index
		if params.key? :user_id
			@user = User.find(params[:user_id])
		else
			@user = nil
		end
		
		respond_with @user do |format|
			format.json { render :json => @user.to_json }
		end	
	end
 
	def create
	end

end
