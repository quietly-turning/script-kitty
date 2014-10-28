module QueriesHelper
	def give_meaining_to(status)
		if status == 0
			return "Invalid"
		elsif status == 1
			return "Valid, but incorrect"
		elsif status == 2
			return "Correct"
		end
	end
end
