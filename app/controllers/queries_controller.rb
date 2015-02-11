class QueriesController < ApplicationController

	before_filter :authenticate_user!

	rescue_from ActiveRecord::StatementInvalid do |exception|
		# if we're in this resucue block, it means the query didn't execute
		# and we're still on the learner db connection
		# switch the app back to using the primary db connection now
		ActiveRecord::Base.establish_connection("#{Rails.env}".intern)

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
	  @lessons_first_half =  @lessons[0..3]
	  @lessons_second_half = @lessons[4..7]
	  @next_lesson_to_try = 1
	  continue_searching_for_next_lesson = true

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
					 @queries[exercise.lesson_id][exercise.dummy_id] = query
				 end

				 if continue_searching_for_next_lesson
					 if query and query.status == 2
						 if exercise.dummy_id == exercises.size
							 # when the learner is 100% done, this will evaluate to lessons.size + 1
							 # we'll check for that and handle it in the _messages partial
							 @next_lesson_to_try += 1
						 end
					 else
						 continue_searching_for_next_lesson = false
					 end
				 end
			 end
		 end
	  end
  end

  # GET /queries/1
  # GET /queries/1.json
  def show
      @query = Query.find(params[:id])

	  # don't allow learners to peek at each others' work!
	  if @query.user_id != current_user.id
		  redirect_to root_path and return
	  end

	  @exercise = @query.exercise
	  lesson = @exercise.lesson

	  num_exercises = Exercise.where(lesson_id: lesson.id).size

	  if @exercise.dummy_id < num_exercises
		 @next_exercise = Exercise.where(lesson_id: lesson.id, dummy_id: (@exercise.dummy_id + 1)).take

	  elsif @exercise.dummy_id == num_exercises and (lesson.id + 1 <= Lesson.all.size)
		 @next_lesson = Lesson.find(lesson.id + 1)
	  end
  end

  # GET /queries/new
  def new
    @query = Query.new
    @operators = Operator.all
    @condition = @query.conditions.build
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
			if @query.status == 2
				check_if_done()
			end

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

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_query
      # @query = Query.find(params[:id])
    end

	def check_if_done
		exercises = Exercise.all
		exercises.each do |exercise|
			query = Query.where(user_id: current_user.id, exercise_id: exercise.id, status: 2)

			if query.empty?
				return
			end
			if exercise.id == exercises.size
				current_user.update!(done: 1)
			end
		end
	end

    # Never trust parameters from the scary internet, only allow the white list through.
    def query_params
      params.require(:query)
	  	.permit(:raw_sql, :exercise_id)
    end

end