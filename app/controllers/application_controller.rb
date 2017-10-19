class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  rescue_from CanCan::AccessDenied do |exception|
  	redirect_to main_app.root_url, alert: exception.message
	end
	rescue_from ActiveRecord::RecordNotFound do |exception|
		redirect_to main_app.root_url, alert: "You are not authorized to do that."
	end
	rescue_from NameError do |exception|
		redirect_to main_app.root_url, alert: "You are not authorized to do that."
	end

end
