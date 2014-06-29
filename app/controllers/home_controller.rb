class HomeController < ApplicationController
  def index
      respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @query }
    end
  end
end
