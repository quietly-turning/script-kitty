module QueriesHelper
	def give_meaning_to(status)
		if status == 0
			return "<span class='invalid'>Invalid</span>"
		elsif status == 1
			return "<span class='valid'>Valid, but incorrect</span>"
		elsif status == 2
			return "<span class='correct'>Correct</span>"
		end
	end
end
