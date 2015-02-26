class AdminController < ApplicationController
	before_filter :verify_is_admin

	def index
		flash.discard(:notice)
		@thing = "hello world"
	end

	def users
		@users = User.order(:id).page params[:page]
	end

	def queries
		@queries = Query.order(:id).page params[:page]
	end
end