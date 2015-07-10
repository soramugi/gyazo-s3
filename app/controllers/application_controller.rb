class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :null_session

  rescue_from StandardError, with: :not_found

  before_action :redirect_url

  def redirect_url
    if ENV['REDIRECT_URL'].present?
      uri = URI(ENV['REDIRECT_URL'])
      if request.host != uri.host
        redirect_to ENV['REDIRECT_URL'] + request.path ,status: 301
      end
    end
  end

  def not_found
    render status: 404, template: 'errors/not_found.html.erb'
  end
end
