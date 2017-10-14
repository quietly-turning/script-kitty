class ExercisesController < ApplicationController

  before_action :authenticate_user!
  before_action :set_exercise, only: [:show]

  # GET /exercises
  # GET /exercises.json
  def index
    @exercises = Exercise.all
  end

  # GET /exercises/1
  # GET /exercises/1.json
  def show
	  @exercise = Exercise.where(lesson_id: params[:lesson_id], dummy_id: params[:id]).take
      @query = Query.new
	  @raw_sql = ""

	  # a paramter might exist if the user made a mistake typing the query
	  # the last time around and we were just redirected here...
	  if not params[:raw_sql].nil?
	  	@raw_sql = params[:raw_sql]
	  end

	  # if current_user.visual_interface?
	  #     @operators = Operator.all
	  #     @condition = @query.conditions.build
	  # end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_exercise
      @exercise = Exercise.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def exercise_params
      params.require(:exercise).permit()
    end
end