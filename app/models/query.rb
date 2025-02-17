class Query < ActiveRecord::Base
    belongs_to  :exercise
    belongs_to  :user

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


		# handle empty queries; this is unlikely but here just in case...
		elsif error.include? "Mysql2::Error: Query was empty:"
			message = "<span class='oops'>Oops!</span>  It looks like your your query was empty."


		# table doesn't exist
		elsif error =~ /Mysql2::Error: Table '\w+.(\w+)' doesn't exist:/
			nonexistent_table = (/Mysql2::Error: Table '\w+.(\w+)' doesn't exist:/.match(error)).captures[0]
			message = "<span class='oops'>Oops!</span>  It seems that the table <span class='causing-the-error'>#{nonexistent_table}</span> doesn't exist."


		# column in where clause doesn't exist
		elsif error =~ /Mysql2::Error: Unknown column '(.+)' in 'where clause'/
			unknown_column = (/Unknown column '(.+)' in 'where clause'/.match(error)).captures[0]
			message = "<span class='oops'>Oops!</span>  It seems that the column <span class='causing-the-error'>#{unknown_column}</span> in your <span class='causing-the-error'>where clause</span>&nbsp; doesn't exist."

			tables = parse_out_tables(error)
			if tables.size == 1
				correction = check_for_misspelling( tables[0], unknown_column )
				if correction
					message += " Did you mean <span class='causing-the-error'>#{correction}</span>?"
				end
			end


		# column in select clause doesn't exist
		elsif error =~ /Mysql2::Error: Unknown column '(.+)' in 'field list':/
			unknown_column = (/Unknown column '(.+)' in 'field list':/.match(error)).captures[0]

			tables = parse_out_tables(error)

			# if only one table was queried, state that the column doesn't belong
			# to that particular table
			if tables.size == 1
				message = "<span class='oops'>Oops!</span>  It seems that the column <span class='causing-the-error'>#{unknown_column}</span> in your<br> <span class='causing-the-error'>select statement</span> does not belong to the #{tables[0]} table."
			else
				message = "<span class='oops'>Oops!</span>  It seems that the column <span class='causing-the-error'>#{unknown_column}</span> in your<br> <span class='causing-the-error'>select statement</span> doesn't exist."
			end

			# the unknown column string contains a dot, so the table might not exist,
			# or the column might not belong to that table; try to be helpful
			if unknown_column.include?(".")
				 temp = unknown_column.split(".")
				 table = temp[0]
				 column = temp[1]
				 connection = ActiveRecord::Base.establish_connection("#{Rails.env}".intern).connection

				 if not connection.table_exists? (table)
					 message = "<span class='oops'>Oops!</span>  It seems that the table <span class='causing-the-error'>#{table}</span> in your<br> statement <span class='causing-the-error'>select #{unknown_column}</span> doesn't exist."
				 elsif not connection.column_exists?(table, column)
					 message = "<span class='oops'>Oops!</span>  It seems that the column <span class='causing-the-error'>#{column}</span> in your<br> statement <span class='causing-the-error'>select #{unknown_column}</span> doesn't exist."
				 end
			end

			if tables.size == 1
				correction = check_for_misspelling( tables[0], unknown_column )
				if correction
					message += " Did you mean <span class='causing-the-error'>#{correction}</span>?"
				end
			end


		# abiguous column in where clause
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

		# ambiguous column in select clause
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

		# malicious query?
		elsif error =~ /Mysql2::Error: \w+ command denied to user/
			denied_command = (/Error: (\w+) command denied to user/.match(error)).captures[0]
			if denied_command == "SELECT"
				nonexistent_table = (/for table '(\w+)':/.match(error)).captures[0]
				message = "<span class='oops'>Oops!</span>  It seems that the table <span class='causing-the-error'>#{nonexistent_table}</span> doesn't exist."

			else
				message = "<span class='oops'>Woah there.</span>  This is Script Kitty, not Script Kiddie..."
			end

		# malicious query!
		elsif error =~ /Access denied for user/
			message = "<span class='oops'>Woah there.</span>  This is Script Kitty, not Script Kiddie..."

		end

		return message
	end

########################################################

	def check_for_misspelling(tab, col)
		letters = col.split(//).sort.join
		columns = tab.singularize.camelize.constantize.column_names
		columns.each do |column|
			if letters == column.split(//).sort.join
				return column
			end
		end
		return nil
	end

	def parse_out_tables(error)

		tables = Array.new
		temp = ""

		if (/from(.+)/im).match(error)
			# capture everything from "from" until the end of the query
			temp = (/from(.+)/im).match(error).captures[0]
		end

		# temp might have a where statement, but might not; truncate either way
		temp = temp.sub((/where.+/im), "" )

		# we might need to parse table names out of (maybe multiple) JOIN statements
		if (/join\s*(\w+)\s*on\s*/im).match(temp)
			tables += (/join\s*(\w+)\s*on\s*/im).match(temp).captures
		end

		# there might be more than one table listed in the FROM clause
		table_str = temp.sub((/join\s+(\w+)\s+on.+/im), "" ).sub((/from/im), "")

		# delimited by commas, of course
		tables += table_str.gsub(/\s+/,"").split(',')

		for t in tables
			puts t
		end

		return tables
	end

########################################################
########################################################

    def constructHTMLtable_simple
		htmlTable = ""

		# temporarily switch the db connection to use the learner user credentials (SELECT only)
		learner_connection = ActiveRecord::Base.establish_connection("#{Rails.env}_learner".intern).connection
        @result = learner_connection.execute(self.raw_sql)

		# switch the app back to using the primary db connection
		ActiveRecord::Base.establish_connection("#{Rails.env}".intern)

		if not @result
			return
		end

		# store the true size of the result set now
		self.result_size = @result.size

	    htmlTable += "<table class='table table-sm'>"
	    htmlTable += "\n\t<thead>\n\t\t<tr>"

		# http://rubydoc.info/gems/mysql2/0.2.6/Mysql2/Result#fields-instance_method
		for field in @result.fields
			if field != "created_at" and field != "updated_at"
				htmlTable += "\n\t\t\t<th>" + CGI::escapeHTML(field) + "</th>"
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

		        @result[i].each do |value|
		            htmlTable += "\n\t\t\t<td>" + CGI::escapeHTML(value.to_s) + "</td>"
		        end
				htmlTable += "\n\t\t</tr>"
	        end

		#otherwise, there are fewer than 500 results in the set, so fetch them all
		else
	        for row in @result

				htmlTable += "\n\t\t<tr>"

	            row.each do |value|
	                htmlTable += "\n\t\t\t<td>" + CGI::escapeHTML(value.to_s) + "</td>"
	            end
				htmlTable += "\n\t\t</tr>"
	        end
		end


		htmlTable += "\n\t</tbody>"
		htmlTable += "\n\n</table>"

        self.html_table = htmlTable
    end

########################################################

	def check_if_correct

		# SHA the resulting HTML table and compare against a verified hash
		hash = Digest::SHA2.hexdigest(self.html_table)

		# puts "\n\n\n\n\n\n\n"
		# puts hash
		# puts "\n\n\n\n\n\n\n"

		# valid but incorrect -- set this now as default
		self.status = 1

		# do we need to check against multiple possible permutations?
		if self.exercise.answers.size > 1
			self.exercise.answers.each do |answer|
				if hash == answer.result_set_hash
					self.status = 2
					break
				end
			end

		# otherwise, there is only one possible correct answer
		else
			if hash == self.exercise.answers.first.result_set_hash
				self.status = 2
			end
		end
	end
end