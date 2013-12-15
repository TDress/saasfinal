class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  #protect_from_forgery with: :exception
  protect_from_forgery

  after_filter  :set_csrf_cookie_for_ng

  def set_csrf_cookie_for_ng
    cookies['XSRF-TOKEN'] = form_authenticity_token if protect_against_forgery?
  end

  def require_user
    if !session.key? :userId
      return render :status => :forbidden, :json => {error: "Please log in to complete this action."}
    end
  end

  #
  # Provide support for before_filters such as require_param_name that send HTTP 400 when 'name' is missing
  #
  def method_missing(method, *args, &block)
    param = method.to_s[/^require_param_([0-z_]+)$/, 1]
    if !param.nil?
      if !params.key? param.to_sym
        return render :status => :bad_request, :json => {error: "Required parameter '#{param}' not specified"}
      end
    else
      raise NoMethodError, "no such method #{method} for #{self}"
    end
  end

protected

  def verified_request?
    super || form_authenticity_token == request.headers['X-XSRF-TOKEN']
  end

end
