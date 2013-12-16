module LinkedIn
  include HTTParty
  base_uri "https://api.linkedin.com"

  #
  # Generate a URL for redirection to LinkedIn's authentication page
  #
  # ==== Parameters
  # +callback+ - URL where user will be redirected when authentication completes
  # +state+ - Random data for CSRF protection
  #
  def self.auth_url(callback, state)
    return "https://www.linkedin.com/uas/oauth2/authorization?response_type=code&client_id=#{key}"\
           "&scope=r_basicprofile%20r_emailaddress&state=#{URI.encode_www_form_component(state)}"\
           "&redirect_uri=#{URI.encode_www_form_component(callback)}"
  end

  #
  # Exchange an authorization code from LinkedIn for an access token
  #
  # ==== Parameters
  # +code+ - The authorization code provided by LinkedIn
  # +redirect_uri+ - Must match the redirect uri that was sent when requesting the authorization code
  #
  # ==== Returns
  # User object for making authenticated requests on behalf of the user
  #
  def self.access_token(code, redirect_uri)
    params = {
        grant_type: "authorization_code",
        code: code,
        redirect_uri: redirect_uri,
        client_id: key,
        client_secret: secret
    }

    response = post('/uas/oauth2/accessToken', body: params)

    return LinkedInUser.new response['access_token']
  end

  class LinkedInUser
    include HTTParty
    base_uri "https://api.linkedin.com"

    def initialize(accessToken)
      @accessToken = accessToken
    end

    #
    # Get the profile of the user, requesting it from LinkedIn if it hasn't already been loaded
    #
    def profile
      if !defined? @profile
        request = get("/v1/people/~:(id,email-address,first-name,last-name,public-profile-url,picture-url)")

        @profile = request.parsed_response['person']
      end

      return @profile
    end

    #
    # Get some property of the user's profile
    #
    def method_missing(name, *args, &block)
      return profile[name.to_s]
    end

    def get(path, body={}, params={})
      request = self.class.get(path + '?oauth2_access_token=' + @accessToken, {
          body: body,
          params: params
      })

      if request.code != 200
        raise RequestFailedException.new(response.parsed_response), "Request failed: #{response.body}"
      end

      return request
    end

  end

  class LinkedInException < Exception

  end

  class RequestFailedException < LinkedInException
    attr_reader :response

    def initialize(response)
      @response = response
    end
  end

  #
  # Set the API key to be used for all requests. Can only be set once
  #
  def self.key=(key)
    if defined? @@key
      raise LinkedInException, "API key already set"
    end

    @@key = key
  end

  #
  # Set the API secret to be used for all requests. Can only be set once
  #
  def self.secret=(secret)
    if defined? @@secret
      raise LinkedInException, "API secret already set"
    end

    @@secret = secret
  end

  def self.key
    if !defined? @@key
      raise LinkedInException, "API key not set"
    end

    return @@key
  end

  def self.secret
    if !defined? @@secret
      raise LinkedInException, "API secret not set"
    end

    return @@secret
  end

  def post(path, body={}, params={})
    response = self.class.post(path, {
        body: body,
        params: params
    })

    if response.code != 200
      raise RequestFailedException.new(response.parsed_response), "Request failed: #{response.body}"
    end

    return response
  end

end
