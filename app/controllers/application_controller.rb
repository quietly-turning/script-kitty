class ApplicationController < ActionController::Base
	# Prevent CSRF attacks by raising an exception.
	# For APIs, you may want to use :null_session instead.
	protect_from_forgery with: :exception

	before_action :topbar

	# layout "application"


	private

		def verify_is_admin
	    	(not current_user) ? (redirect_to root_path and return) : (redirect_to root_path and return unless current_user.admin?)
		end
		def verify_is_educator
	    	(not current_user) ? (redirect_to root_path and return) : (redirect_to root_path and return unless current_user.educator?)
		end

		# routes users appropriately after login
		def after_sign_in_path_for(resource)
			# admin
			if current_user and current_user.admin
				admin_index_path

			# non-admin with some queries completed
			elsif current_user and Query.where(user_id: current_user.id).size > 0
				queries_path

			# non-admin with no queries completed
			else
				root_path
			end
		end

		def topbar
			@lessons ||= Lesson.all
			@exercises ||= Exercise.all.order(lesson_id: :asc, dummy_id: :asc)
		end

	protected

end