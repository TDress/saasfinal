class SessionController < ApplicationController
  require "xmlsimple"
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
      return
    end

    if params.key? :error
      @event = 'loginFailed'
      @result = JSON.dump({error: params[:error], error_description: params[:error_description]})

      logger.warn "Authentication Failed: #{@result}"
      return
    end

    # We have a valid request, exchange the auth code
    tokenResponse = HTTParty.post('https://www.linkedin.com/uas/oauth2/accessToken',
                                  body: {
                                      grant_type: "authorization_code",
                                      code: params[:code],
                                      redirect_uri: request.original_url.gsub(/\?.*$/i, ''),
                                      client_id: Rails.application.config.secrets['linkedin']['key'],
                                      client_secret: Rails.application.config.secrets['linkedin']['secret']
                                  })

    tokenResponseData = JSON.parse(tokenResponse.body)
    if tokenResponse.code != 200
      @event = 'loginFailed'
      @result = JSON.dump(tokenResponseData)

      logger.warn "Authentication Failed: #{@result}"
      return
    end

    accessToken = tokenResponseData['access_token']

    # Get user's profile (not just their ID), in case they are a new user
    profileResponse = HTTParty.get("https://api.linkedin.com/v1/people/~:(id,email-address,first-name,last-name)?oauth2_access_token=#{accessToken}")
    profileData = XmlSimple.xml_in(profileResponse.body, {keyAttr: 'name', forceArray: false})
    logger.info "Response: #{profileData}"

    user = User.find_by_linkedin_id(profileData['id'])
    if user.nil?
      # This is a new user
      userData = {
          name: "#{profileData['first-name']} #{profileData['last-name']}",
          email: profileData['email-address'],
          linkedin_id: profileData['id']
      }

      logger.info "Creating a new user: #{userData}"
      user = User.create(userData)
    end

    @event = 'loginSuccess'
    @result = user.to_json
    cookies[:userId] = user.id
  end

  def create
    callback = url_for(controller: 'session', action: 'oauth2_callback')
    state = URI.encode_www_form_component(cookies[:"XSRF-TOKEN"])

    redirect = "https://www.linkedin.com/uas/oauth2/authorization?response_type=code&client_id="
    redirect += "#{Rails.configuration.secrets['linkedin']['key']}&scope=r_basicprofile%20r_emailaddress&state="
    redirect += "#{state}&redirect_uri=#{URI.encode_www_form_component(callback)}"

    redirect_to redirect
  end

  def destroy
    cookies.delete :userId

    redirect_to root_path
  end

end
