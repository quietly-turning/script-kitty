class ApplicationController < ActionController::Base
	# Prevent CSRF attacks by raising an exception.
	# For APIs, you may want to use :null_session instead.
	protect_from_forgery with: :exception

	layout "application"

    private

		def verify_is_admin
	    	(not current_user) ? (redirect_to root_path and return) : (redirect_to root_path and return unless current_user.admin?)
		end

	  def after_sign_in_path_for(resource)
  		if current_user and Query.where(user_id: current_user.id).size > 0
  			queries_path
		else
			root_path
		end
	  end

	protected

end