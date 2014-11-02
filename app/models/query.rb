class Query < ActiveRecord::Base
    belongs_to  :exercise
    belongs_to  :user
    has_many :conditions
    has_many :operators, :through => :conditions
    accepts_nested_attributes_for :conditions


	require 'digest'

########################################################
########################################################

	def friendly_errors(error)
		message = "<span class='oops'>Oops!</span>  There is some sort of problem with your query!"

		if error.include? "Mysql2::Error: You have an error in your SQL syntax;"
			line_number = (/at line (\d+):/.match(error)).captures[0]
			query_str = ((/at line \d+: (.+)/).match(error)).captures[0]

			message = "<span class='oops'>Oops!</span>  You seem to have a syntax error near &nbsp;<span class='causing-the-error'>line #{line_number}</span>."

			# if the error occured on line 1, and the query IS only 1 line,
			# encourage the learner to break the query into multiple lines
			# for more helpful error reporting
			if line_number == "1" and query_str.chop!.lines.count == 1
				message += "<br><em>Try writing your query using multiple lines for more specific error-reporting.</em>"
			end

		elsif error.include? "Mysql2::Error: Query was empty:"
			message = "<span class='oops'>Oops!</span>  It looks like your your query was empty."

		elsif error =~ /Mysql2::Error: Table 'thesis.(\w+)' doesn't exist:/
			nonexistent_table = (/thesis.(\w+)/.match(error)).captures[0]
			message = "<span class='oops'>Oops!</span>  It seems that the table <span class='causing-the-error'>#{nonexistent_table}</span> doesn't exist."

		elsif error =~ /Mysql2::Error: Unknown column '(\w+)' in 'where clause'/
			unknown_column = (/Unknown column '(\w+)' in 'where clause'/.match(error)).captures[0]
			message = "<span class='oops'>Oops!</span>  It seems that the column &nbsp;<span class='causing-the-error'>#{unknown_column}</span>&nbsp; in your<br>&nbsp;<span class='causing-the-error'>where clause</span>&nbsp; doesn't exist."

		elsif error =~ /Mysql2::Error: Unknown column '(.+)' in 'field list':/
			unknown_column = (/Unknown column '(.+)' in 'field list':/.match(error)).captures[0]
			message = "<span class='oops'>Oops!</span>  It seems that the column &nbsp;<span class='causing-the-error'>#{unknown_column}</span>&nbsp; in your<br>&nbsp;<span class='causing-the-error'>select statement</span>&nbsp; doesn't exist."

			if unknown_column.include?(".")
				 temp = unknown_column.split(".")
				 table = temp[0]
				 column = temp[1]
				 connection = ActiveRecord::Base.connection
				 if not connection.table_exists? (table)
					 message = "<span class='oops'>Oops!</span>  It seems that the table &nbsp;<span class='causing-the-error'>#{table}</span>&nbsp; in your<br> statement <span class='causing-the-error'>select #{unknown_column}</span>&nbsp; doesn't exist."
				 elsif not connection.column_exists?(table, column)
					 message = "<span class='oops'>Oops!</span>  It seems that the column &nbsp;<span class='causing-the-error'>#{column}</span>&nbsp; in your<br>statement <span class='causing-the-error'>select #{unknown_column}</span>&nbsp; doesn't exist."
				 end
			end

		elsif error =~ /Mysql2::Error: Column '\w+' in where clause is ambiguous:/
			ambiguous_column = (/Column '(\w+)' in where clause is ambiguous:/.match(error)).captures[0]
			table_str = ((/from (.+)where/im).match(error)).captures[0]
			tables = table_str.gsub(/\s+/,"").split(',')
			message = "<span class='oops'>Oops!</span> The <span class='causing-the-error'>#{ambiguous_column}</span> in your <span class='causing-the-error'>WHERE #{ambiguous_column}</span> is somewhat ambiguous.<br> Did you mean "
			tables.each_with_index do |t,i|
				message += "<span class='causing-the-error'>#{t}.#{ambiguous_column}</span>"
				if i < tables.size - 1
					message += " or "
				end
			end
			message += " ?"

		elsif error =~ /Mysql2::Error: Column '\w+' in field list is ambiguous:/
			ambiguous_column = (/Column '(\w+)' in field list is ambiguous:/.match(error)).captures[0]
			table_str = ((/from (.+)where/im).match(error)).captures[0]
			tables = table_str.gsub(/\s+/,"").split(',')
			message = "<span class='oops'>Oops!</span> <span class='causing-the-error'>SELECT #{ambiguous_column}</span> is somewhat ambiguous.<br> Did you mean "
			tables.each_with_index do |t,i|
				message += "<span class='causing-the-error'>#{t}.#{ambiguous_column}</span>"
				if i < tables.size - 1
					message += " or "
				end
			end
			message += " ?"
		end

		return message
	end

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