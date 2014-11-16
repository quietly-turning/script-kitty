class WebsitesController < ApplicationController

  # GET /websites
  # GET /websites.json
  def index
    @websites = Website.order(:id).page params[:page]
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_website
      # @website = Website.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def website_params
      params.require(:website).permit()
    end
end
