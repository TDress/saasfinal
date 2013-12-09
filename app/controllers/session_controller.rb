class SessionController < ApplicationController
  layout "dialog"

  #
  # Exchange an authorization code from LinkedIn for an accessToken and get query user's LinkedIn profile
  #
  # ===== Parameters
  # * +code+ - The authorization code
  # * +state+ - Must match the state parameter sent to LinkedIn
  #
  def oauth2_callback
    if params[:state] != cookies[:"XSRF-TOKEN"]
      @event = 'loginFailed'
      @result = JSON.dump({error: "forbidden", error_description: "XSRF Token Mismatch"})

      logger.warn "Authentication Failed: #{@result}"
      return render status: 403
    end

    if params.key? :error
      @event = 'loginFailed'
      @result = JSON.dump({error: params[:error], error_description: params[:error_description]})

      logger.warn "Authentication Failed: #{@result}"
      return render status: 403
    end

    # We have a valid request, exchange the auth code
    begin
      linked_in_user = LinkedIn.access_token(params[:code], request.original_url.gsub(/\?.*$/i, ''))
    rescue LinkedIn::RequestFailedException => e
      @event = 'loginFailed'
      @result = e.response

      logger.warn "Authentication Failed: #{@e}"
      return render status: 403
    end

    user = User.find_by_linkedin_id(linked_in_user.id)
    if user.nil?
      # This is a new user
      userData = {
          name: "#{linked_in_user.first_name} #{linked_in_user.last_name}",
          email: linked_in_user.email_address,
          linkedin_id: linked_in_user.id,
          linkedin_url: linked_in_user.public_profile_url
      }

      logger.info "Creating a new user: #{userData}"
      user = User.create(userData)
    end

    @event = 'loginSuccess'
    @result = user.to_json
    session[:userId] = cookies[:userId] = user.id
  end

  def create
    callback = url_for(controller: 'session', action: 'oauth2_callback')
    state = cookies[:"XSRF-TOKEN"]

    redirect_to LinkedIn.auth_url(callback, state)
  end

  def destroy
    cookies.delete :userId
    session.delete :userId

    redirect_to root_path
  end

end
