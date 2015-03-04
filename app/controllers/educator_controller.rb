class EducatorController < ApplicationController
	before_filter :verify_is_educator

	def index
		# don't bother showing educators the flash-notification about having logged in
		flash.discard(:notice)
	end

	def users
		@users = User.order(:id).page params[:page]
	end
end