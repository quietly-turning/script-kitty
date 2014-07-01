class Query < ActiveRecord::Base
    belongs_to  :exercise
    belongs_to  :user
    has_many :conditions
    has_many :operators, :through => :conditions
    accepts_nested_attributes_for :conditions
    
########################################################  
########################################################

  # build an HTML-formatted query for the end-user to see
  def constructFormattedQuery

    query = self.raw_sql
    # trim off the preliminary SQL that isn't a condition
    q = query.split("WHERE\s")

    # split the conglomerate condition into andGroups by searching for (" or ") via regex
    andGroups = q[1].split(/\sor\s/)

    # break each andGroup down further into distinct conditions by searching for (" and ")
    parsedConditions = andGroups.map do |group|
       group.split(/\sand\s/) 
    end

    # # # # # # # # # ## # #

    html = "<div class='selectStatement'><em>select</em> * from <strong>animals</strong> <em>where</em> </div>\n\n<div style='padding-top:22px' id=\"subQuery0\" class='andGrouping'>"

    parsedConditions.each_with_index do |conditionGroup, index|
  
      if index > 0
        html += "\n\t<div class=\"orString\">or</div>"
      end
  
      conditionGroup.each do |condition|
        html += "\n\t<div class='conditionString'>#{condition}</div>"    
      end
      #close the previous .andGroup 
      html += "\n</div>\n"     

      # if this is NOT the last andGrouping
      if index+1 < parsedConditions.size     
        # open a new andGroup
        html += "\n<div class=\"andGrouping\" id=\"subQuery#{index+1}\">"
      end
    end

    self.formatted_sql = html

  end


########################################################  
########################################################


  def processConditions
  
    c = ""
    andGroups = Array.new
    conditions = Array.new
    entireString = ""

    self.conditions.each do |cond|
  
      parameter_is_numeric = false
      # use regex to determine if the parameter is numeric
      if (/^[\d]+(\.[\d]+){0,1}$/ === cond.parameter)
        parameter_is_numeric = true
      end

      column_is_boolean = false
      if cond.column == "nocturnal"
        if cond.parameter == "true"
          p = 1
        else
          p = 0
        end
        column_is_boolean = true
      end

      if column_is_boolean
        c = cond.column + " " + cond.operator.sql_value + " " + p.to_s
      else
        if cond.operator.name == "like" and !parameter_is_numeric
          c = cond.column + " " + cond.operator.sql_value + " '%" + cond.parameter + "%'"
        elsif parameter_is_numeric && (cond.operator.name == "greaterthan" || cond.operator.name == "lessthan")
          c = cond.column + " " + cond.operator.sql_value + " " +  cond.parameter
        else
          c = cond.column + " " + cond.operator.sql_value + " '" +  cond.parameter + "'"
        end
      end

      if cond.complexOperator != nil
        c += " " + cond.complexOperator + " "
      end

      conditions << c
      entireString += c      
   
    
      # if we're starting a new OR chunk of the sql string
      if cond.complexOperator == "or"
        andGroups << conditions 
        conditions.drop(conditions.size)
      end    
  
    end   # end of each-loop that handled all the conditions of this query

    self.raw_sql       = "SELECT * FROM animals WHERE #{entireString}"
  end


########################################################  
########################################################


  def constructHTMLtable
    rows = Array.new
    merged = Array.new

    query = self.raw_sql
    # trim off the preliminary SQL that isn't a condition
    q = query.split("WHERE\s")

    # split the conglomerate condition into andGroups by searching for (" or ") via regex
    andGroups = q[1].split(/\sor\s/)

    # break each andGroup down further into distinct conditions by searching for (" and ")
    parsedConditions = andGroups.map do |group|
      group.split(/\sand\s/) 
    end

    # # # # # # # # # ## # #
    
    andGroups.each do |condition|
      # rows << Animal.find_by_sql("SELECT * FROM animals WHERE #{condition}")
    end
    
    rows.each do |resultSet|
      merged += resultSet
    end

    merged.uniq!    

    htmlTable  = "<table class=\"dataTable\" cellspacing=\"0\" cellpadding=\"6\">"
    htmlTable += "\n\t<thead>\n\t\t<tr>"
 
    htmlTable += "\n\t\t\t<th>Name</th>\n\t\t\t<th>Habitat</th>\n\t\t\t<th>Nocturnal</th>\n\t\t\t<th>Diet</th>\n\t\t\t<th>Weight</th>"
 
    htmlTable += "\n\t\t</tr>\n\t</thead>"
    htmlTable += "\n\n\t<tbody>"

    merged.each do |m|
      cls = String.new
  
      rows.each_with_index do |r, index|
        if r.include?(m)
          cls += "subQuery#{index} "
        end
      end
     
      htmlTable += "\n\n\t\t<tr class=\"#{cls}\">"
      htmlTable += "\n\t\t\t<td>" + m.name + "</td>"
      htmlTable += "\n\t\t\t<td>" + m.habitat + "</td>"
      htmlTable += "\n\t\t\t<td>" + m.nocturnal.to_s + "</td>"
      htmlTable += "\n\t\t\t<td>" + m.diet + "</td>"
      htmlTable += "\n\t\t\t<td>" + m.weight.to_s + "</td>"
      htmlTable += "\n\t\t</tr>"
    end   # end of merged.each

    htmlTable += "\n\t</tbody>"     
    htmlTable += "\n\n</table>"
  
    self.html_table = htmlTable  
  end   # end of constructHTMLtable method    

########################################################  
########################################################
	
    def constructHTMLtable_simple
		htmlTable = ""
				
		connection = ActiveRecord::Base.connection
        @result = ActiveRecord::Base.connection.execute(self.raw_sql)
		
		# we don't really want created_at and updated_at attributes showing up in results
		# these are flags
		includes_created_at = @result.fields.include? "created_at"
		includes_updated_at = @result.fields.include? "updated_at"


		# enforce a limit of 500 results per query
		# this helps mitigate the likelihood of a user crashing/stalling the app
		# create an alert box above the results table if necessary
		unless @result.nil?
			if @result.size >= 500
				htmlTable += "<div data-alert class=\"alert-box warning radius small-4\">"
				htmlTable += "There are #{@result.to_a.size} records in this result set!<br>"
				htmlTable += "We're only showing the first 500.</div>"
			end
		end
		
	    htmlTable += "<table>"
	    htmlTable += "\n\t<thead>\n\t\t<tr>"
		
		unless @result.nil?
			# http://rubydoc.info/gems/mysql2/0.2.6/Mysql2/Result#fields-instance_method
			for field in @result.fields
				if field != "created_at" and field != "updated_at"
					htmlTable += "\n\t\t\t<th>" + field + "</th>"
				end
			end
		end
		
		htmlTable += "\n\t\t</tr>\n\t</thead>"
		htmlTable += "\n\n\t<tbody>"
		
		unless @result.nil?
			# if there are more than 500 results, only bother fetching the first 500
			if @result.size >= 500
				
				@result = @result.to_a
		        for i in 0...500
				
					htmlTable += "\n\t\t<tr>"
					if includes_created_at and includes_updated_at
						for j in 0...(@result[i].size-2)
							htmlTable += "\n\t\t\t<td>" + @result[i][j].to_s + "</td>"
						end
					else
			            @result[i].each do |value|
			                htmlTable += "\n\t\t\t<td>" + value.to_s + "</td>"
			            end
					end
					htmlTable += "\n\t\t</tr>"
		        end
			
			#otherwise, there are fewer than 500 results in the set, so fetch them all
			else
		        for row in @result
				
					htmlTable += "\n\t\t<tr>"
					if includes_created_at and includes_updated_at
						for i in 0...(row.size-2)
							htmlTable += "\n\t\t\t<td>" + row[i].to_s + "</td>"
						end
					else
			            row.each do |value|
			                htmlTable += "\n\t\t\t<td>" + value.to_s + "</td>"
			            end
					end
					htmlTable += "\n\t\t</tr>"
		        end
			end
		end
		
		htmlTable += "\n\t</tbody>"    
		htmlTable += "\n\n</table>"
		
        self.html_table = htmlTable
    end

end
