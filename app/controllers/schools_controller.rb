class SchoolsController < ApplicationController

  # GET /schools
  # GET /schools.json
  def index
    @schools = School.order(:id).page params[:page]
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_school
      # @school = School.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def school_params
      params.require(:school).permit()
    end
end