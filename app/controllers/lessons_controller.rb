class LessonsController < ApplicationController

  # GET /lessons/1
  # GET /lessons/1.json
  def show
	  @lesson = Lesson.find(params[:id])
  end

  private

    # Never trust parameters from the scary internet, only allow the white list through.
    def lesson_params
      params.require(:lesson).permit()
    end
end
