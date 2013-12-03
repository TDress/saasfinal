class SessionController < ApplicationController
  def oauth2_callback
    if params[:state] != cookies[:"XSRF-TOKEN"]
      @event = 'loginFailed'
      @result = {error: "forbidden", error_description: "XSRF Token Mismatch"}

      logger.warn "Authentication Failed: #{@result}"
      return
    end

    if params.key? :error
      @event = 'loginFailed'
      @result = {error: params[:error], error_description: params[:error_description]}

      logger.warn "Authentication Failed: #{@result}"
      return
    end

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
      @result = tokenResponseData

      logger.warn "Authentication Failed: #{@result}"
      return
    end

    logger.debug "Token Response: " + tokenResponse.body
    tokenResponseData = JSON.parse(tokenResponse.body)
    accessToken = tokenResponseData['access_token']

    profileResponse = HTTParty.get("https://api.linkedin.com/v1/people/~:(id,first-name,last-name)?oauth2_access_token=#{accessToken}")

    logger.info "Response: " + profileResponse.body

    @event = 'loginSuccess'
    @result = tokenResponse.body
  end

  def create
    callback = url_for(controller: 'session', action: 'oauth2_callback')

    redirect_to "https://www.linkedin.com/uas/oauth2/authorization?response_type=code&client_id=" +
                Rails.configuration.secrets['linkedin']['key'] + "&scope=r_basicprofile%20r_emailaddress&state=" +
                cookies[:"XSRF-TOKEN"] + "&redirect_uri=" +
                URI.encode_www_form_component(callback)
  end

end
