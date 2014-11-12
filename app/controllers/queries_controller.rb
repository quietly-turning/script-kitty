class QueriesController < ApplicationController

  before_filter :authenticate_user!
  before_filter :verify_is_admin, only: [:edit, :destroy]
  before_action :set_query, only: [:show, :edit, :update, :destroy]

  rescue_from ActiveRecord::StatementInvalid do |exception|
	  exercise = Exercise.find(params[:query][:exercise_id])
	  lesson = Lesson.find(exercise.lesson_id)
	  query = Query.where(user_id: current_user.id, exercise_id: exercise.id).last

	  redirect_to lesson_exercise_path(lesson, exercise, {:raw_sql => params[:query][:raw_sql]} ),
		 						alert: query.friendly_errors(exception.message)
  end

  # GET /queries
  # GET /queries.json
  def index
	  @lessons = Lesson.all
	  @lessons_first_half = Lesson.where(id: 1..4)
	  @lessons_second_half = Lesson.where(id: 5..8)


	  if current_user.admin
		 @queries = Query.all
	  else
		 @queries = Array.new

		 @lessons.each do |lesson|
			 @queries[lesson.id] = Array.new
			 exercises = Exercise.where(lesson_id: lesson.id)

			 exercises.each do |exercise|
				 query = Query.where(user_id: current_user.id, exercise_id: exercise.id).last

				 if query
					 @queries[exercise.lesson_id] << query
				 end
			 end
		 end

	  end
  end

  # GET /queries/1
  # GET /queries/1.json
  def show
	  @query = Query.find(params[:id])
	  exercise = @query.exercise
	  lesson = exercise.lesson

	  num_exercises = Exercise.where(lesson_id: lesson.id).size

	  if exercise.dummy_id < num_exercises
		 @next_exercise = Exercise.where(lesson_id: lesson.id, dummy_id: (exercise.dummy_id + 1)).take

	  elsif exercise.dummy_id == num_exercises and (lesson.id + 1 <= Lesson.all.size)
		 @next_lesson = Lesson.find(lesson.id + 1)
	  end
  end

  # GET /queries/new
  def new
    @query = Query.new
    @operators = Operator.all
    @condition = @query.conditions.build
  end

  # GET /queries/1/edit
  def edit
	 @query = Query.find(params[:id])
	 # redirect_to lesson_exercise_path(@query.exercise.lesson, @query.exercise.dummy_id, {:raw_sql => @query.raw_sql} )
  end

  # POST /queries
  # POST /queries.json
  def create
    @query = Query.new(query_params)
    @query.user_id = current_user.id

	if not @query.html_table
		# mySQL doesn't allow default values for text columns
		# so, we set this here, instead
		@query.html_table = "<em>( no results returned )</em>"
	end

	respond_to do |format|
		# save the query data first
		if @query.save

			# then attempt to run it and check its correctness
			if current_user.visual_interface?
				# @query.processConditions
				# @query.constructFormattedQuery
				# @query.constructHTMLtable
			else
				@query.constructHTMLtable_simple
			end

			@query.check_if_correct

			# then update the query entry
			if @query.save
				if @query.status == 2
					format.html { redirect_to @query, notice: 'correct' }
				else
					format.html { redirect_to @query, notice: 'incorrect' }
				end
				format.json { render :show, status: :created, location: @query }
			else

		    	format.html { render :edit }
		   	 	format.json { render json: @query.errors, status: :unprocessable_entity }
			end
		else
			format.html { render :new }
	    	format.json { render json: @query.errors, status: :unprocessable_entity }
	  	end
	end
  end


 	# PATCH/PUT /queries/1
  	# PATCH/PUT /queries/1.json
 	 def update

		# Because this is a study, and we are actually interested in incorrect answers,
		# don't actually ever edit a query, just create a new one!  In this way, mistakes
		# are logged for later analysis.  This method is a effectively a copy/paste of create.

		@query = Query.new(query_params)
		@query.user_id = current_user.id

		if current_user.visual_interface?
		  # @query.processConditions
		  # @query.constructFormattedQuery
		  # @query.constructHTMLtable
		else
		  @query.constructHTMLtable_simple
		end

		@query.check_if_correct

		respond_to do |format|
			if @query.save
				if @query.status == 2
					format.html { redirect_to @query, notice: 'correct' }
				else
					format.html { redirect_to @query, notice: 'incorrect' }
				end
				format.json { render :show, status: :ok, location: @query }
		    else
				format.html { render :edit }
				format.json { render json: @query.errors, status: :unprocessable_entity }
		    end
		end
	end

  # DELETE /queries/1
  # DELETE /queries/1.json
  def destroy
    @query.destroy
    respond_to do |format|
      format.html { redirect_to queries_url, notice: 'Query was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_query
      @query = Query.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def query_params
      params.require(:query)
	  	.permit(:raw_sql, :exercise_id)
    end

end