class AdminController < ApplicationController
	before_filter :verify_is_admin

	def index
		# don't bother showing admins the flash-notification about having logged in
		flash.discard(:notice)
	end

	def users
		@users = User.order(:id).page params[:page]
	end

	def queries
		@queries = Query.order(:id).page params[:page]
	end

	def edit_user
		@user = User.find(params[:id])
	end


	def update_user
		@user = User.find(params[:id])
		@user.update(admin: params[:user][:admin])
		redirect_to admin_users_path
	end
end