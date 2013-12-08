# Initialize the LinkedIn api
require "#{Rails.application.config.root}/lib/linkedin"

LinkedIn.key = Rails.application.config.secrets['linkedin']['key']
LinkedIn.secret = Rails.application.config.secrets['linkedin']['secret']
