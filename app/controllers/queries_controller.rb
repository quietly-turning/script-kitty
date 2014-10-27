class QueriesController < ApplicationController
  
  before_filter :authenticate_user!
  before_filter :verify_is_admin, only: [:destroy]
  before_action :set_query, only: [:show, :edit, :update, :destroy]
  rescue_from ActiveRecord::StatementInvalid do |exception|
  	redirect_to exercise_path(params[:query][:exercise_id], {:raw_sql => params[:query][:raw_sql]} ),
		 						alert: friendly_errors(exception.message)
  end
  
  # GET /queries
  # GET /queries.json
  def index
    @queries = Query.all
  end

  # GET /queries/1
  # GET /queries/1.json
  def show
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
	 redirect_to exercise_path( @query.exercise.id, {:raw_sql => @query.raw_sql} )
  end

  # POST /queries
  # POST /queries.json
  def create
    @query = Query.new(query_params)
    @query.user_id = current_user.id
    @query.dummy_id = current_user.queries.count + 1

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
			if @query.update(query_params)
				if @query.correct
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
	@query.dummy_id = current_user.queries.count + 1

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
		  if @query.correct
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
	  	.permit(:name, :dummy_id, :formatted_sql, :raw_sql, :html_table, :user_id, :exercise_id)
    end
	
	def friendly_errors(error)
		message = "<span class='oops'>Oops!</span>  There is some sort of problem with your query!"

		if error.include? "Mysql2::Error: You have an error in your SQL syntax;"
			line_number = (/at line (\d+):/.match(error)).captures[0]
			message = "<span class='oops'>Oops!</span>  You seem to have a syntax error near &nbsp;<span class='causing-the-error'>line #{line_number}</span>."
		
		elsif error.include? "Mysql2::Error: Query was empty:"
			message = "<span class='oops'>Oops!</span>  It looks like your your query was empty."
		
		elsif error =~ /Mysql2::Error: Table 'thesis.(\w+)' doesn't exist:/
			nonexistent_table = (/thesis.(\w+)/.match(error)).captures[0]
			message = "<span class='oops'>Oops!</span>  It seems that the table <span class='causing-the-error'>#{nonexistent_table}</span> doesn't exist."
		
		elsif error =~ /Mysql2::Error: Unknown column '(\w+)' in 'where clause'/
			unknown_colummn = (/Unknown column '(\w+)' in 'where clause'/.match(error)).captures[0]
			message = "<span class='oops'>Oops!</span>  It seems that the column &nbsp;<span class='causing-the-error'>#{unknown_colummn}</span>&nbsp; in your<br>&nbsp;<span class='causing-the-error'>where clause</span>&nbsp; doesn't exist."
		
		elsif error =~ /Mysql2::Error: Unknown column '(\w+)' in 'field list': select/
			unknown_colummn = (/Unknown column '(\w+)' in 'field list': select/.match(error)).captures[0]
			message = "<span class='oops'>Oops!</span>  It seems that the column &nbsp;<span class='causing-the-error'>#{unknown_colummn}</span>&nbsp; in your<br>&nbsp;<span class='causing-the-error'>select statement</span>&nbsp; doesn't exist."	
				
		end
		
		return message
	end
end
