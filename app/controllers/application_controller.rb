class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :null_session

  rescue_from StandardError, with: :not_found

  def not_found
    render status: 404, template: 'errors/not_found.html.erb'
  end
end
