class LocalesController < ApplicationController

  # GET /locales
  # GET /locales.json
  def index
    @locales = Locale.all
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_locale
      # @locale = Locale.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def locale_params
      params.require(:locale).permit()
    end
end
