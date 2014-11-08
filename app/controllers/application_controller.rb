class ApplicationController < ActionController::Base
	# Prevent CSRF attacks by raising an exception.
	# For APIs, you may want to use :null_session instead.
	protect_from_forgery with: :exception
  
	layout "application"

    rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
 
    private
      def record_not_found
        redirect_to root_path
      end
	  
	  def verify_is_admin
	    (not current_user) ? (redirect_to root_path) : (redirect_to root_path unless current_user.admin?)
	  end
  
end
