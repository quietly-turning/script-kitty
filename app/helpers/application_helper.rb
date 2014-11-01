module ApplicationHelper
	def user_exercise_status(exercise)
		queries = Query.where(user_id: current_user.id, exercise_id: exercise.id)
		if queries
			query = queries.last

			if query

				# invalid
				if query.status == 0
					return "<span class='invalid'>&#x2717;</span>"

				# valid, but incorrect
				# elsif query.status == 1
				# 	return ""

				# correct
				elsif query.status == 2
					return "<span class='correct'>&#x2713;</span>"
				end
			end
		end

		return ""
	end
end
