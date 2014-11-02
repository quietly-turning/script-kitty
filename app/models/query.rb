class Query < ActiveRecord::Base
    belongs_to  :exercise
    belongs_to  :user
    has_many :conditions
    has_many :operators, :through => :conditions
    accepts_nested_attributes_for :conditions
    
	
	require 'digest'

########################################################  
########################################################
	
    def constructHTMLtable_simple
		htmlTable = ""
				
		connection = ActiveRecord::Base.connection
        @result = ActiveRecord::Base.connection.execute(self.raw_sql)
		
		if not @result
			return
		end
		
		# we don't really want created_at and updated_at attributes showing up in results
		# these are flags
		includes_created_at = @result.fields.include? "created_at"
		includes_updated_at = @result.fields.include? "updated_at"

		# store the true size of the result set now
		self.result_size = @result.size
		
	    htmlTable += "<table>"
	    htmlTable += "\n\t<thead>\n\t\t<tr>"
		
		# http://rubydoc.info/gems/mysql2/0.2.6/Mysql2/Result#fields-instance_method
		for field in @result.fields
			if field != "created_at" and field != "updated_at"
				htmlTable += "\n\t\t\t<th>" + field + "</th>"
			end
		end
		
		htmlTable += "\n\t\t</tr>\n\t</thead>"
		htmlTable += "\n\n\t<tbody>"
		
			
		# enforce a limit of 500 results per query
		# this helps mitigate the likelihood of a user crashing/stalling the app
		# if there are more than 500 results, only bother fetching the first 500
		if @result.size >= 500
			self.truncated_results = 1
			
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

		
		htmlTable += "\n\t</tbody>"    
		htmlTable += "\n\n</table>"
		
        self.html_table = htmlTable
    end

	def check_if_correct
		
		# SHA the resulting HTML table and compare against a verified hash
		hash = Digest::SHA2.hexdigest(self.html_table)
		
		# puts "\n\n\n\n\n\n\n"
		# puts hash
		# puts "\n\n\n\n\n\n\n"
		
		if hash == self.exercise.result_set_hash
			self.status = 2
		else
			self.status = 1
		end
	end

end
